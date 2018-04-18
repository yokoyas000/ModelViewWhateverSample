//
//  MVPSample2Presenter.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

class MVPSample2Presenter: MVPSample2PresenterProtocol {

    private weak var starModel: DelayStarModelProtocol?
    private weak var navigationModel: NavigationRequestModelProtocol?
    private let view: MVPSample2InteractiveView

    init(
        interchange models: (
            starModel: DelayStarModelProtocol,
            navigationModel: NavigationRequestModelProtocol
        ),
        willUpdate view: MVPSample2InteractiveView
    ) {
        self.starModel = models.starModel
        self.navigationModel = models.navigationModel
        self.view = view

        self.starModel?.append(receiver: self)
        self.navigationModel?.append(receiver: self)
    }

}

extension MVPSample2Presenter: MVPSampleRootViewDelegate, MVPSample2InteractiveViewDelegate {
 
    @objc func didTapnavigationButton() {
        guard let model = self.starModel else {
            return
        }

        // 現在の Model の状態による分岐処理
        switch model.state {
        case .sleeping(current: .star):
            self.view.navigate(with: model)
        case .sleeping(current: .unstar), .processing:
            self.view.alertForNavigation()
        }
    }

    @objc func didTapStarButton() {
        self.starModel?.toggleStar()
    }

    func didRequestForceNavigate() {
        self.navigationModel?.requestToNavigate()
        self.starModel?.star()
    }

    private func update(by state: DelayStarModelState) {
        switch state {
        case .processing(next: .star):
            self.view.updateStarButton(title: "★", color: .darkGray)
        case .processing(next: .unstar):
            self.view.updateStarButton(title: "☆", color: .darkGray)
        case .sleeping(current: .star):
            self.view.updateStarButton(title: "★", color: .red)
        case .sleeping(current: .unstar):
            self.view.updateStarButton(title: "☆", color: .red)
        }
    }

}

extension MVPSample2Presenter: DelayStarModelReceiver {
    func receive(starState: DelayStarModelState) {
        self.update(by: starState)
    }
}

extension MVPSample2Presenter: NavigationRequestModelReceiver {
    func receive(requestState: NavigationRequestModelState) {
        switch requestState {
        case .haveNeverRequest, .notReady:
            return
        case .ready:
            guard let model = self.starModel else {
                return
            }
            self.view.navigate(with: model)
        }
    }
}
