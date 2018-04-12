//
//  MVCSample1Controller.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

class MVCSample1Controller {

    private let navigateButton: UIButton
    private let starButton: UIButton
    private let model: StarModel
    private let navigator: NavigatorContract
    private let modalPresenter: ModalPresenterContract

    init(
        reactTo views: (
            starButton: UIButton,
            navigateButton: UIButton
        ),
        willCommand model: StarModel,
        navigateBy navigator: NavigatorContract,
        presentBy modalPresenter: ModalPresenterContract
    ) {
        self.starButton = views.starButton
        self.navigateButton = views.navigateButton
        self.model = model
        self.navigator = navigator
        self.modalPresenter = modalPresenter

        // 1. 遷移ボタンを持ち、タップされた時にSub画面へ遷移する
        self.navigateButton.addTarget(
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
        if self.model.isStar {
            self.navigate()
        } else {
            self.alertForNavigation()
        }
    }

    @objc private func didTapStarButton() {
        self.model.toggleStar()
    }

    private func alertForNavigation() {
        let alert = UIAlertController(title: "", message: "★にしないと遷移できません。", preferredStyle: .alert)
        let navigate = UIAlertAction(
            title: "無視して遷移する",
            style: .default
        ) { [weak self] _ in
            self?.navigate()
        }

        let cancel = UIAlertAction(
            title: "OK",
            style: .cancel
        )

        alert.addAction(navigate)
        alert.addAction(cancel)

        self.modalPresenter.present(to: alert)
    }

    private func navigate() {
        guard let vc = SubViewController.create(model: self.model) else {
            return
        }
        self.navigator.navigate(to: vc)
    }

}
