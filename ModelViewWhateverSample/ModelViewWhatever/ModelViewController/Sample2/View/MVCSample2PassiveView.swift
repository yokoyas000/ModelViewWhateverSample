//
//  MVCSample2PassiveView.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

class MVCSample2PassiveView: MVCSample2PassiveViewProtocol {

    private let starButton: UIButton
    private let navigator: NavigatorProtocol
    private let modalPresenter: ModalPresenterContract

    init(
        willUpdate starButton: UIButton,
        navigateBy navigator: NavigatorProtocol,
        presentBy modalPresenter: ModalPresenterContract
    ) {
        self.starButton = starButton
        self.navigator = navigator
        self.modalPresenter = modalPresenter
    }

    func navigate(with model: DelayStarModelProtocol) {
        self.navigator.navigate(
            to: SyncStarViewController(model: model)
        )
    }

    func present(alert: UIAlertController) {
        self.modalPresenter.present(to: alert)
    }

    func update(by starState: DelayStarModelState) {
        switch starState {
        case .processing(next: .star):
            self.starButton.setTitle("★", for: .normal)
            self.starButton.setTitleColor(.darkGray, for: .normal)
            self.starButton.isEnabled = false
        case .processing(next: .unstar):
            self.starButton.setTitle("☆", for: .normal)
            self.starButton.setTitleColor(.darkGray, for: .normal)
            self.starButton.isEnabled = false
        case .sleeping(current: .star):
            self.starButton.setTitle("★", for: .normal)
            self.starButton.setTitleColor(.red, for: .normal)
            self.starButton.isEnabled = true
        case .sleeping(current: .unstar):
            self.starButton.setTitle("☆", for: .normal)
            self.starButton.setTitleColor(.red, for: .normal)
            self.starButton.isEnabled = true
        }
    }

}
