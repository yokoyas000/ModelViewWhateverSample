//
//  MVCSample1Controller.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

// Controllerの役割:
//  - UI要素とアクションの接続
//  - 状態に適したアクションの振り分け
class MVCSample1Controller {

    private let starModel: DelayStarModelProtocol
    private let navigationModel: NavigationRequestModelProtocol
    private let view: MVCSample1ViewHandler

    init(
        reactTo handle: (
            starButton: UIButton,
            navigationButton: UIButton
        ),
        command models: (
            starModel: DelayStarModelProtocol,
            navigationModel: NavigationRequestModelProtocol
        ),
        update view: MVCSample1ViewHandler
    ) {
        self.starModel = models.starModel
        self.navigationModel = models.navigationModel
        self.view = view

        // ユーザー動作の受付
        handle.navigationButton.addTarget(
            self,
            action: #selector(MVCSample1Controller.didTapnavigationButton),
            for: .touchUpInside
        )
        handle.starButton.addTarget(
            self,
            action: #selector(MVCSample1Controller.didTapStarButton),
            for: .touchUpInside
        )
    }

    @objc private func didTapnavigationButton() {
        // 現在の Model の状態による分岐処理
        switch self.starModel.state {
        case .sleeping(current: .star):
            self.view.navigate()
        case .sleeping(current: .unstar), .processing:
            self.view.present(
                alert: self.createNavigateAlert()
            )
        }
    }

    @objc private func didTapStarButton() {
        self.starModel.toggleStar()
    }

    // アクションの完了(Model結果)に伴い画面遷移(Viewへ指示)する
    private func createNavigateAlert() -> UIAlertController {
        let alert = UIAlertController(
            title: "",
            message: "★にしないと遷移できません。",
            preferredStyle: .alert
        )
        let navigate = UIAlertAction(
            title: "★にして遷移する",
            style: .default
        ) { [weak self] _ in
            guard let this = self else {
                return
            }

            this.navigationModel.requestToNavigate()
            this.starModel.star()
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
