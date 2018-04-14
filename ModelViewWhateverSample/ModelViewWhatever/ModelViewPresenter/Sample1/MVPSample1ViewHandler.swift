//
//  MVPSample1ViewHandler.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

// Viewの役割:
//  - 画面の構築/表示
//  - UI要素とアクションの接続
//  - 内部表現を視覚表現へ変換する
//  - アクションの結果/途中経過を受け取る
protocol MVPSample1ViewHandlerDelegate: class {
    func didTapNavigationAlertAction()
}

class MVPSample1ViewHandler {

    private let navigationButton: UIButton
    private let starButton: UIButton
    private let model: DelayStarModel
    private let navigator: NavigatorContract
    private let modalPresenter: ModalPresenterContract
    weak var delegate: MVPSample1ViewHandlerDelegate?

    init(
        handle: (
            starButton: UIButton,
            navigationButton: UIButton
        ),
        observe model: DelayStarModel,
        navigateBy navigator: NavigatorContract,
        presentBy modalPresenter: ModalPresenterContract
    ) {
        self.starButton = handle.starButton
        self.navigationButton = handle.navigationButton
        self.model = model
        self.navigator = navigator
        self.modalPresenter = modalPresenter

        // Modelの監視を開始する
        self.model.append(receiver: self)
    }

    func navigate(with model: DelayStarModel) {
        self.navigator.navigate(
            to: SyncStarViewController(model: model)
        )
    }

    func alertForNavigation() {
        self.modalPresenter.present(to: self.createNavigateAlert())
    }

    private func createNavigateAlert() -> UIAlertController {
        let alert = UIAlertController(title: "", message: "★にしないと遷移できません。", preferredStyle: .alert)
        let navigate = UIAlertAction(
            title: "無視して遷移する",
            style: .default
        ) { [weak self] _ in
            self?.delegate?.didTapNavigationAlertAction()
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
