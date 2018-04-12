//
//  MVPSample1ViewHandler.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

class MVPSample1ViewHandler {

    private let navigateButton: UIButton
    private let starButton: UIButton
    private let model: StarModel
    private let presenter: MVPSample1Presenter
    private let navigator: NavigatorContract
    private let modalPresenter: ModalPresenterContract

    init(
        handle: (
            starButton: UIButton,
            navigateButton: UIButton
        ),
        willNotify presenter: MVPSample1Presenter,
        observe model: StarModel,
        navigateBy navigator: NavigatorContract,
        presentBy modalPresenter: ModalPresenterContract
    ) {
        self.starButton = handle.starButton
        self.navigateButton = handle.navigateButton
        self.presenter = presenter
        self.model = model
        self.navigator = navigator
        self.modalPresenter = modalPresenter

        self.presenter.view = self

        // Modelの監視を開始する
        self.model.append(receiver: self)

        // ユーザー動作の受付
        self.navigateButton.addTarget(
            self.presenter,
            action: #selector(MVPSample1Presenter.didTapNavigateButton),
            for: .touchUpInside
        )
        self.starButton.addTarget(
            self.presenter,
            action: #selector(MVPSample1Presenter.didTapStarButton),
            for: .touchUpInside
        )
    }

    func navigate(to next: UIViewController) {
        self.navigator.navigate(to: next)
    }

    func alert() {
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
            self?.presenter.didTapAlertAction()
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

extension MVPSample1ViewHandler: StarModelReceiver {

    // Modelの変更を画面へ反映する
    func receive(isStar: Bool) {
        let title = isStar ? "★": "☆"
        self.starButton.setTitle(title, for: .normal)
    }
}
