//
//  SyncStarViewHandler.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/13.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

// ViewHandlerの役割(※責務過多):
//  - 内部表現を視覚表現へ変換する
//  - ユーザー操作の受付
//  - 状態に適した処理の振り分け
//  - Modelから指示の結果/途中経過を受け取る
//  - Modelへ指示を送る
class SyncStarViewHandler {

    private let starButton: UIButton
    private weak var model: DelayStarModel?
    private let modalPresenter: ModalPresenter

    init(
        handle starButton: UIButton,
        interchange model: DelayStarModel,
        presentBy modalPresenter: ModalPresenter
    ) {
        self.starButton = starButton
        self.model = model
        self.modalPresenter = modalPresenter

        self.model?.append(receiver: self)

        self.starButton.addTarget(
            self,
            action: #selector(SyncStarViewHandler.didTapStarButton),
            for: .touchUpInside
        )
    }

    @objc private func didTapStarButton() {
        guard let model = self.model else {
            return
        }

        switch model.state {
        case .sleeping(current: .star), .processing(next: .star):
            self.model?.unstar()
        case .sleeping(current: .unstar), .processing(next: .unstar):
            self.model?.star()
        }
    }

    private func update(star isStar: Bool, color: UIColor) {
        let title = isStar ? "★" : "☆"
        self.starButton.setTitle(title, for: .normal)
        self.starButton.setTitleColor(color, for: .normal)
    }
}

extension SyncStarViewHandler: DelayStarModelReceiver {

    func receive(status: DelayStarModel.State) {
        switch status {
        case .processing(next: .star):
            self.update(star: true, color: UIColor.darkGray)
        case .processing(next: .unstar):
            self.update(star: false, color: UIColor.darkGray)
        case .sleeping(current: .star):
            self.update(star: true, color: UIColor.red)
            self.modalPresenter.present(to: self.createStarAlert())
        case .sleeping(current: .unstar):
            self.update(star: false, color: UIColor.red)
        }
    }

    private func createStarAlert() -> UIAlertController {
        let alert = UIAlertController(
            title: "",
            message: "★をつけました！",
            preferredStyle: .alert
        )
        let cancel = UIAlertAction(title: "OK",style: .cancel)
        alert.addAction(cancel)

        return alert
    }
}
