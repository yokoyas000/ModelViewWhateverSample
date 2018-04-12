//
//  MVCSample1Controller.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

class MVCSample1Controller {

    private let model: StarModel
    private let view: MVCSample1ViewHandler

    init(
        reactTo handle: (
            starButton: UIButton,
            navigateButton: UIButton
        ),
        willCommand model: StarModel,
        interchange view: MVCSample1ViewHandler
    ) {
        self.model = model
        self.view = view

        // ユーザー動作の受付
        handle.navigateButton.addTarget(
            self,
            action: #selector(MVCSample1Controller.didTapNavigateButton),
            for: .touchUpInside
        )
        handle.starButton.addTarget(
            self,
            action: #selector(MVCSample1Controller.didTapStarButton),
            for: .touchUpInside
        )
    }

    @objc private func didTapNavigateButton() {
        // 現在の状態による分岐処理
        if self.model.isStar {
            self.navigate()
        } else {
            self.alertForNavigation()
        }
    }

    @objc private func didTapStarButton() {
        // Modelへ指示を行う
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

        // 画面への反映は View が行う
        self.view.alert(alert)
    }

    private func navigate() {
        guard let vc = SubViewController.create(model: self.model) else {
            return
        }

        // 画面への反映は View が行う
        self.view.navigate(to: vc)
    }

}
