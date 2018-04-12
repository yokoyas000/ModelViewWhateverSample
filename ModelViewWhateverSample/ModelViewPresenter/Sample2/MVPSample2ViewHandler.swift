//
//  MVPSample2ViewHandler.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

class MVPSample2ViewHandler {

    private let navigateButton: UIButton
    private let starButton: UIButton
    private let navigator: NavigatorContract
    private let presenter: MVPSample2Presenter
    private let modalPresenter: ModalPresenterContract

    init(
        handle: (
            starButton: UIButton,
            navigateButton: UIButton
        ),
        interchange presenter: MVPSample2Presenter,
        navigateBy navigator: NavigatorContract,
        presentBy modalPresenter: ModalPresenterContract
    ) {
        self.starButton = handle.starButton
        self.navigateButton = handle.navigateButton
        self.presenter = presenter
        self.navigator = navigator
        self.modalPresenter = modalPresenter

        self.presenter.connect(view: self)

        // ユーザー動作の受付
        self.navigateButton.addTarget(
            self.presenter,
            action: #selector(MVPSample2Presenter.didTapNavigateButton),
            for: .touchUpInside
        )
        self.starButton.addTarget(
            self.presenter,
            action: #selector(MVPSample2Presenter.didTapStarButton),
            for: .touchUpInside
        )   
    }

    func navigate(to next: UIViewController) {
        self.navigator.navigate(to: next)
    }

    func update(starTitle: String) {
        self.starButton.setTitle(starTitle, for: .normal)
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
