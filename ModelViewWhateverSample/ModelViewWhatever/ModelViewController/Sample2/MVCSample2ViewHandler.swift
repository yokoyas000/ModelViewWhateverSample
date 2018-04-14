//
//  MVCSample2ViewHandler.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

// Viewの役割:
//  - 内部表現を視覚表現へ変換する
class MVCSample2ViewHandler {

    private let starButton: UIButton
    private let navigator: NavigatorContract
    private let modalPresenter: ModalPresenterContract

    init(
        willUpdate starButton: UIButton,
        navigateBy navigator: NavigatorContract,
        presentBy modalPresenter: ModalPresenterContract
    ) {
        self.starButton = starButton
        self.navigator = navigator
        self.modalPresenter = modalPresenter
    }

    func navigate(with model: DelayStarModel) {
        self.navigator.navigate(
            to: SyncStarViewController(model: model)
        )
    }

    func present(alert: UIAlertController) {
        self.modalPresenter.present(to: alert)
    }

    func update(by status: DelayStarModel.State) {
        switch status {
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
