//
//  MVPSample1Presenter.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

class MVPSample1Presenter {

    private let model: StarModel
    weak var view: MVPSample1ViewHandler?

    init(
        willCommand model: StarModel
    ) {
        self.model = model
    }

    @objc func didTapNavigateButton() {
        // 現在の状態による分岐などの場合, Viewの操作が許可される
        if self.model.isStar {
            self.navigate()
        } else {
            self.view?.alert(self.createNavigateAlert())
        }
    }

    @objc func didTapStarButton() {
        self.model.toggleStar()
    }

    private func navigate() {
        guard let vc = SubViewController.create(model: self.model) else {
            return
        }
        self.view?.navigate(to: vc)
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
}
