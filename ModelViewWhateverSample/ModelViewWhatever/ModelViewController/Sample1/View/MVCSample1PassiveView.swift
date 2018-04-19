//
//  MVCSample1PassiveView.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

class MVCSample1PassiveView: MVCSample1PassiveViewProtocol {

    private let starButton: UIButton
    private let starModel: DelayStarModelProtocol
    private let navigationModel: NavigationRequestModelProtocol
    private let navigator: NavigatorProtocol
    private let modalPresenter: ModalPresenterContract
    private lazy var starModelReceiver: AnyDelayStarModelReceiver = {
        AnyDelayStarModelReceiver(self)
    }()

    init(
        willUpdate starButton: UIButton,
        observe models: (
            starModel: DelayStarModelProtocol,
            navigationModel: NavigationRequestModelProtocol
        ),
        navigateBy navigator: NavigatorProtocol,
        presentBy modalPresenter: ModalPresenterContract
    ) {
        self.starButton = starButton
        self.starModel = models.starModel
        self.navigationModel = models.navigationModel
        self.navigator = navigator
        self.modalPresenter = modalPresenter

        // Modelの監視を開始する
        self.starModel.append(receiver: self.starModelReceiver)
        self.navigationModel.append(receiver: self)
    }

    func navigate() {
        self.navigator.navigate(
            to: SyncStarViewController(model: self.starModel)
        )
    }

    func present(alert: UIAlertController) {
        self.modalPresenter.present(to: alert)
    }

}

extension MVCSample1PassiveView: DelayStarModelReceiver {

    func receive(starState: DelayStarModelState) {
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

extension MVCSample1PassiveView: NavigationRequestModelReceiver {

    func receive(requestState: NavigationRequestModelState) {
        switch requestState {
        case .haveNeverRequest, .notReady:
            return
        case .ready:
            self.navigate()
        }
    }

}

