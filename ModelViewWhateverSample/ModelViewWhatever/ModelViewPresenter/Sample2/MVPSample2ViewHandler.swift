//
//  MVPSample2ViewHandler.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

// Viewの役割:
//  - 画面の構築/表示
//  - UI要素とアクションの接続
protocol MVPSample2ViewHandlerDelegate: class {
    func didRequestForceNavigate()
}

class MVPSample2ViewHandler {

    private let navigationButton: UIButton
    private let starButton: UIButton
    private let navigator: NavigatorContract
    private let modalPresenter: ModalPresenterContract
    weak var delegate: MVPSample2ViewHandlerDelegate?

    init(
        handle: (
            starButton: UIButton,
            navigationButton: UIButton
        ),
        navigateBy navigator: NavigatorContract,
        presentBy modalPresenter: ModalPresenterContract
    ) {
        self.starButton = handle.starButton
        self.navigationButton = handle.navigationButton
        self.navigator = navigator
        self.modalPresenter = modalPresenter
    }

    func navigate(with model: DelayStarModel) {
        self.navigator.navigate(
            to: SyncStarViewController(model: model)
        )
    }

    func updateStarButton(title: String, color: UIColor) {
        self.starButton.setTitle(title, for: .normal)
        self.starButton.setTitleColor(color, for: .normal)
    }

    func alertForNavigation() {
        self.modalPresenter.present(
            to: self.createNavigateAlert()
        )
    }

    private func createNavigateAlert() -> UIAlertController {
        let alert = UIAlertController(title: "", message: "★にしないと遷移できません。", preferredStyle: .alert)
        let navigate = UIAlertAction(
            title: "無視して遷移する",
            style: .default
        ) { [weak self] _ in
            self?.delegate?.didRequestForceNavigate()
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
