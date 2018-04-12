//
//  MVCSample1Controller.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

class MVCSample1Controller {

    private let transitionButton: UIButton
    private let starButton: UIButton
    private let model: StarModel
    private let navigator: NavigatorContract

    init(
        reactTo views: (
            starButton: UIButton,
            transitionButton: UIButton
        ),
        willCommand model: StarModel,
        navigateBy navigator: NavigatorContract
    ) {
        self.starButton = views.starButton
        self.transitionButton = views.transitionButton
        self.model = model
        self.navigator = navigator

        // 1. 遷移ボタンを持ち、タップされた時にSub画面へ遷移する
        self.transitionButton.addTarget(
            self,
            action: #selector(MVCSample1Controller.didTapNavigateButton),
            for: .touchUpInside
        )

        // 2. Starボタンを持ち、タップされた時にModelへ指示を出す
        self.starButton.addTarget(
            self,
            action: #selector(MVCSample1Controller.didTapStarButton),
            for: .touchUpInside
        )
    }

    @objc private func didTapNavigateButton() {
        guard let subVC = SubViewController.create(model: self.model) else {
            return
        }

        self.navigator.navigate(to: subVC)
    }

    @objc private func didTapStarButton() {
        self.model.toggleStar()
    }

}
