//
//  MVPSample1ViewHandler.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

// Viewの役割:
//  - ユーザー操作の受付
//  - 内部表現を視覚表現へ変換する
//  - Modelから指示の結果/途中経過を受け取る
class MVPSample1ViewHandler {

    private let navigateButton: UIButton
    private let starButton: UIButton
    private let model: DelayStarModel
    private let presenter: MVPSample1Presenter
    private let navigator: NavigatorContract
    private let modalPresenter: ModalPresenterContract

    init(
        handle: (
            starButton: UIButton,
            navigateButton: UIButton
        ),
        willNotify presenter: MVPSample1Presenter,
        observe model: DelayStarModel,
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
        self.modalPresenter.present(to: self.createNavigateAlert())
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

extension MVPSample1ViewHandler: DelayStarModelReceiver {

    // Modelの変更を画面へ反映する
    func receive(state: DelayStarModel.State) {
        switch state {
        case .processing(next: .star):
            self.starButton.setTitle("★", for: .normal)
            self.starButton.setTitleColor(.darkGray, for: .normal)
        case .processing(next: .unstar):
            self.starButton.setTitle("☆", for: .normal)
            self.starButton.setTitleColor(.darkGray, for: .normal)
        case .sleeping(current: .star):
            self.starButton.setTitle("★", for: .normal)
            self.starButton.setTitleColor(.red, for: .normal)

            // ★にした時だけアラートを表示する
            self.modalPresenter.present(
                to: self.createStarAlert()
            )
        case .sleeping(current: .unstar):
            self.starButton.setTitle("☆", for: .normal)
            self.starButton.setTitleColor(.red, for: .normal)
        }
    }

    private func createStarAlert() -> UIAlertController {
        let alert = UIAlertController(
            title: "",
            message: "★をつけました！",
            preferredStyle: .alert
        )
        let cancel = UIAlertAction(title: "OK",style: .cancel)
        alert.addAction(cancel)

        return alert
    }
}
