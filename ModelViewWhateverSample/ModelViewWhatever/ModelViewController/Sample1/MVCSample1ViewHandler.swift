//
//  MVCSample1ViewHandler.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

// Viewの役割:
//  - 内部表現を視覚表現へ変換する
//  - Modelから指示の結果/途中経過を受け取る
class MVCSample1ViewHandler {

    private let starButton: UIButton
    private weak var model: DelayStarModel?
    private let navigator: NavigatorContract
    private let modalPresenter: ModalPresenterContract

    init(
        willUpdate starButton: UIButton,
        observe model: DelayStarModel,
        navigateBy navigator: NavigatorContract,
        presentBy modalPresenter: ModalPresenterContract
    ) {
        self.starButton = starButton
        self.model = model
        self.navigator = navigator
        self.modalPresenter = modalPresenter

        // Modelの監視を開始する
        self.model?.append(receiver: self)
    }

    func navigate(with model: DelayStarModel) {
        self.navigator.navigate(
            to: SyncStarViewController(model: model)
        )
    }

    func present(alert: UIAlertController) {
        self.modalPresenter.present(to: alert)
    }

    private func update(star title: String, color: UIColor) {
        self.starButton.setTitle(title, for: .normal)
        self.starButton.setTitleColor(color, for: .normal)
    }
}

extension MVCSample1ViewHandler: DelayStarModelReceiver {

    // Modelの変更を画面へ反映する
    func receive(status: DelayStarModel.State) {
        switch status {
        case .processing(next: .star):
            self.update(star: "★", color: UIColor.darkGray)
        case .processing(next: .unstar):
            self.update(star: "☆", color: UIColor.darkGray)
        case .sleeping(current: .star):
            self.update(star: "★", color: UIColor.red)

            // ★にした時だけアラートを表示する
            self.present(alert: self.createStarAlert())
        case .sleeping(current: .unstar):
            self.update(star: "☆", color: UIColor.red)
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
