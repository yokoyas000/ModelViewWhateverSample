//
//  MVCSample2Controller.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

class MVCSample2Controller {

    private let navigateButton: UIButton
    private let starButton: UIButton
    private let model: StarModel
    private let view: MVCSample2ViewHandler

    init(
        reactTo views: (
            starButton: UIButton,
            navigateButton: UIButton
        ),
        interchange model: StarModel,
        willCommand view: MVCSample2ViewHandler
    ) {
        self.starButton = views.starButton
        self.navigateButton = views.navigateButton
        self.model = model
        self.view = view

        // Modelの監視を開始する
        self.model.append(receiver: self)

        // 1. 遷移ボタンを持ち、タップされた時にSub画面へ遷移する
        self.navigateButton.addTarget(
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
        if self.model.isStar {
            self.navigate()
        } else {
            self.view.alert(self.createNavigateAlert())
        }
    }

    @objc private func didTapStarButton() {
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

        return alert
    }

    private func navigate() {
        guard let vc = SubViewController.create(model: self.model) else {
            return
        }
        self.view.navigate(to: vc)
    }
}

extension MVCSample2Controller: StarModelReceiver {

    // 3. ModelからStarボタンの状態("☆/★")を取得し、表示する
    func receive(isStar: Bool) {
        self.view.update(star: isStar)
    }
}
