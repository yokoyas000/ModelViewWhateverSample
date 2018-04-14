//
//  MVCSample1ViewHandler.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

// Viewの役割:
//  - 内部表現を視覚表現へ変換する
//  - Modelから指示の結果/途中経過を受け取る
class MVCSample1ViewHandler {

    private let starButton: UIButton
    private weak var model: DelayStarModel?
    private let navigator: NavigatorContract
    private let modalPresenter: ModalPresenterContract

    init(
        willUpdate starButton: UIButton,
        observe model: DelayStarModel,
        navigateBy navigator: NavigatorContract,
        presentBy modalPresenter: ModalPresenterContract
    ) {
        self.starButton = starButton
        self.model = model
        self.navigator = navigator
        self.modalPresenter = modalPresenter

        // Modelの監視を開始する
        self.model?.append(receiver: self)
    }

    func navigate(with model: DelayStarModel) {
        self.navigator.navigate(
            to: SyncStarViewController(model: model)
        )
    }

    func present(alert: UIAlertController) {
        self.modalPresenter.present(to: alert)
    }

}

extension MVCSample1ViewHandler: DelayStarModelReceiver {

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
            self.present(alert: self.createStarAlert())
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
