//
//  MVCSample2ViewHandler.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit
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

    func navigate(to next: UIViewController) {
        self.navigator.navigate(to: next)
    }

    func alert(_ alert: UIAlertController) {
        self.modalPresenter.present(to: alert)
    }

    func update(star: Bool) {
        let title = star ? "★": "☆"
        self.starButton.setTitle(title, for: .normal)
    }

    


}
