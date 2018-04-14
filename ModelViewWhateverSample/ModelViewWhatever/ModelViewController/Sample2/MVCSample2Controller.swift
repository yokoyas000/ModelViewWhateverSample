//
//  MVCSample2Controller.swift
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
//  - Modelから指示の結果/途中経過を受け取る
class MVCSample2Controller {

    private weak var model: DelayStarModel?
    private let view: MVCSample2ViewHandler

    init(
        reactTo handle: (
            starButton: UIButton,
            navigationButton: UIButton
        ),
        interchange model: DelayStarModel,
        command view: MVCSample2ViewHandler
    ) {
        self.model = model
        self.view = view

        // Modelの監視を開始する
        self.model?.append(receiver: self)

        // ユーザー動作の受付
        handle.navigationButton.addTarget(
            self,
            action: #selector(MVCSample2Controller.didTapnavigationButton),
            for: .touchUpInside
        )
        handle.starButton.addTarget(
            self,
            action: #selector(MVCSample2Controller.didTapStarButton),
            for: .touchUpInside
        )
    }

    @objc private func didTapnavigationButton() {
        guard let model = self.model else {
            return
        }

        // 現在の Model の状態による分岐処理
        switch model.state {
        case .sleeping(current: .star), .processing(next: .star):
            self.view.navigate(with: model)
        case .sleeping(current: .unstar), .processing(next: .unstar):
            self.view.present(
                alert: self.createNavigateAlert()
            )
        }
    }

    @objc private func didTapStarButton() {
        guard let model = self.model else {
            return
        }

        // 現在の Model の状態による分岐処理
        switch model.state {
        case .sleeping(current: .star), .processing(next: .star):
            model.unstar()
        case .sleeping(current: .unstar), .processing(next: .unstar):
            model.star()
        }
    }

    private func createNavigateAlert() -> UIAlertController {
        let alert = UIAlertController(title: "", message: "★にしないと遷移できません。", preferredStyle: .alert)
        let navigate = UIAlertAction(
            title: "無視して遷移する",
            style: .default
        ) { [weak self] _ in
            guard let this = self, let model = this.model else {
                return
            }
            this.view.navigate(with: model)
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

}

extension MVCSample2Controller: DelayStarModelReceiver {
    func receive(state: DelayStarModel.State) {
        self.view.update(by: state)
    }
}
