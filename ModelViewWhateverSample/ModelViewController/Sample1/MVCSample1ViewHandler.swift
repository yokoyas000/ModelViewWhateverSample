//
//  MVCSample1ViewHandler.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

class MVCSample1ViewHandler {

    private let starButton: UIButton
    private let model: StarModel
    private let navigator: NavigatorContract
    private let modalPresenter: ModalPresenterContract

    init(
        willUpdate starButton: UIButton,
        observe model: StarModel,
        navigateBy navigator: NavigatorContract,
        presentBy modalPresenter: ModalPresenterContract
    ) {
        self.starButton = starButton
        self.model = model
        self.navigator = navigator
        self.modalPresenter = modalPresenter

        // Modelの監視を開始する
        self.model.append(receiver: self)
    }

    func navigate(to next: UIViewController) {
        self.navigator.navigate(to: next)
    }

    func alert(_ alert: UIAlertController) {
        self.modalPresenter.present(to: alert)
    }
}

extension MVCSample1ViewHandler: StarModelReceiver {

    // Modelの変更を画面へ反映する
    func receive(isStar: Bool) {
        let title = isStar ? "★": "☆"
        self.starButton.setTitle(title, for: .normal)
    }
}
