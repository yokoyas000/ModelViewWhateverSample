//
//  MVCSample1Controller.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

// Controllerの役割:
//  - ユーザー操作の受付
//  - 状態に適した処理の振り分け
//  - Modelへ指示を送る
class MVCSample1Controller {

    private let model: DelayStarModel
    private let view: MVCSample1ViewHandler

    init(
        reactTo handle: (
            starButton: UIButton,
            navigateButton: UIButton
        ),
        command model: DelayStarModel,
        update view: MVCSample1ViewHandler
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
        // 現在の Model の状態による分岐処理
        switch self.model.state {
        case .sleeping(current: .star), .processing(next: .star):
            self.view.navigate(with: self.model)
        case .sleeping(current: .unstar), .processing(next: .unstar):
            self.view.present(
                alert: self.createNavigateAlert()
            )
        }
    }

    @objc private func didTapStarButton() {
        // 現在の Model の状態による分岐処理
        switch self.model.state {
        case .sleeping(current: .star), .processing(next: .star):
            self.model.unstar()
        case .sleeping(current: .unstar), .processing(next: .unstar):
            self.model.star()
        }
    }

    private func createNavigateAlert() -> UIAlertController {
        let alert = UIAlertController(
            title: "",
            message: "★にしないと遷移できません。",
            preferredStyle: .alert
        )
        let navigate = UIAlertAction(
            title: "無視して遷移する",
            style: .default
        ) { [weak self] _ in
            guard let this = self else {
                return
            }
            this.view.navigate(with: this.model)
        }

        let cancel = UIAlertAction(
            title: "OK",
            style: .cancel
        )

        alert.addAction(navigate)
        alert.addAction(cancel)

        return alert
    }

}
