//
//  MVCSample1PassiveView.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

class MVCSample1PassiveView: MVCSample1PassiveViewProtocol {

    typealias Views = (
        starButton: UIButton,
        navigator: NavigatorProtocol,
        modalPresenter: ModalPresenterProtocol
    )
    typealias Dependency = DelayStarModelProtocol

    private let views: Views
    private let dependency: Dependency
    private lazy var starModelReceiver: AnyDelayStarModelReceiver = {
        AnyDelayStarModelReceiver(self)
    }()

    init(
        handle views: Views,
        dependency: Dependency,
        observe models: (
            starModel: DelayStarModelProtocol,
            navigationModel: NavigationRequestModelProtocol
        )
    ) {
        self.views = views
        self.dependency = dependency

        // Modelの監視を開始する
        models.starModel.append(receiver: self.starModelReceiver)
        models.navigationModel.append(receiver: self)
    }

    func navigate() {
        self.views.navigator.navigate(
            to: SyncStarViewController(
                model: self.dependency
            )
        )
    }

    func present(alert: UIAlertController) {
        self.views.modalPresenter.present(to: alert)
    }

}

extension MVCSample1PassiveView: DelayStarModelReceiver {

    func receive(starState: DelayStarModelState) {
        switch starState {
        case .processing(next: .star):
            self.views.starButton.setTitle("★", for: .normal)
            self.views.starButton.setTitleColor(.darkGray, for: .normal)
            self.views.starButton.isEnabled = false
        case .processing(next: .unstar):
            self.views.starButton.setTitle("☆", for: .normal)
            self.views.starButton.setTitleColor(.darkGray, for: .normal)
            self.views.starButton.isEnabled = false
        case .sleeping(current: .star):
            self.views.starButton.setTitle("★", for: .normal)
            self.views.starButton.setTitleColor(.red, for: .normal)
            self.views.starButton.isEnabled = true
        case .sleeping(current: .unstar):
            self.views.starButton.setTitle("☆", for: .normal)
            self.views.starButton.setTitleColor(.red, for: .normal)
            self.views.starButton.isEnabled = true
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

