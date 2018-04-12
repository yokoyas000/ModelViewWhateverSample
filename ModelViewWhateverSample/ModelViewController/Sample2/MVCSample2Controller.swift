//
//  MVCSample2Controller.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

class MVCSample2Controller {

    private let transitionButton: UIButton
    private let starButton: UIButton
    private let model: StarModel
    private let view: MVCSample2ViewHandler

    init(
        reactTo views: (
            starButton: UIButton,
            transitionButton: UIButton
        ),
        interchange model: StarModel,
        willCommand view: MVCSample2ViewHandler
    ) {
        self.starButton = views.starButton
        self.transitionButton = views.transitionButton
        self.model = model
        self.view = view

        // Modelの監視を開始する
        self.model.append(receiver: self)

        // 1. 遷移ボタンを持ち、タップされた時にSub画面へ遷移する
        self.transitionButton.addTarget(
            self,
            action: #selector(MVCSample2Controller.didTapNavigateButton),
            for: .touchUpInside
        )

        // 2. Starボタンを持ち、タップされた時にModelへ指示を出す
        self.starButton.addTarget(
            self,
            action: #selector(MVCSample2Controller.didTapStarButton),
            for: .touchUpInside
        )
    }

    @objc private func didTapNavigateButton() {
        self.view.navigate(with: self.model)
    }

    @objc private func didTapStarButton() {
        self.model.toggleStar()
    }
}

extension MVCSample2Controller: StarModelReceiver {

    // 3. ModelからStarボタンの状態("☆/★")を取得し、表示する
    func receive(isStar: Bool) {
        self.view.update(star: isStar)
    }
}
