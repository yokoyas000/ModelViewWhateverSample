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
    private let model: DelayStarModelProtocol
    private lazy var starModelReceiver: AnyDelayStarModelReceiver = {
        AnyDelayStarModelReceiver(self)
    }()

    init(
        handle starButton: UIButton,
        interchange model: DelayStarModelProtocol
    ) {
        self.starButton = starButton
        self.model = model
        self.model.append(receiver: self.starModelReceiver)

        self.starButton.addTarget(
            self,
            action: #selector(SyncStarViewHandler.didTapStarButton),
            for: .touchUpInside
        )
    }

    @objc private func didTapStarButton() {
        self.model.toggleStar()
    }

    private func update(star isStar: Bool, color: UIColor) {
        let title = isStar ? "★" : "☆"
        self.starButton.setTitle(title, for: .normal)
        self.starButton.setTitleColor(color, for: .normal)
    }
}

extension SyncStarViewHandler: DelayStarModelReceiver {

    func receive(starState: DelayStarModelState) {
        switch starState {
        case .processing(next: .star):
            self.update(star: true, color: UIColor.darkGray)
        case .processing(next: .unstar):
            self.update(star: false, color: UIColor.darkGray)
        case .sleeping(current: .star):
            self.update(star: true, color: UIColor.red)
        case .sleeping(current: .unstar):
            self.update(star: false, color: UIColor.red)
        }
    }
}
