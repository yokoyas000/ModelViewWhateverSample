//
//  MVCSample2Controller.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

class MVCSample2Controller {

    private let model: StarModel
    private let view: MVCSample2ViewHandler

    init(
        reactTo handle: (
            starButton: UIButton,
            navigateButton: UIButton
        ),
        interchange model: StarModel,
        willCommand view: MVCSample2ViewHandler
    ) {
        self.model = model
        self.view = view

        // Modelの監視を開始する
        self.model.append(receiver: self)

        // ユーザー動作の受付
        handle.navigateButton.addTarget(
            self,
            action: #selector(MVCSample2Controller.didTapNavigateButton),
            for: .touchUpInside
        )
        handle.starButton.addTarget(
            self,
            action: #selector(MVCSample2Controller.didTapStarButton),
            for: .touchUpInside
        )
    }

    @objc private func didTapNavigateButton() {
        // 現在の状態による分岐処理
        if self.model.isStar {
            self.navigate()
        } else {
            self.view.alert(self.createNavigateAlert())
        }
    }

    @objc private func didTapStarButton() {
        // Modelへ指示を行う
        self.model.toggleStar()
    }

    private func createNavigateAlert() -> UIAlertController {
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
        return alert
    }

    private func navigate() {
        guard let vc = SubViewController.create(model: self.model) else {
            return
        }

        // 画面への反映は View が行う
        self.view.navigate(to: vc)
    }
}

extension MVCSample2Controller: StarModelReceiver {

    func receive(isStar: Bool) {
        // 画面への反映は View が行う
        self.view.update(star: isStar)
    }
}
