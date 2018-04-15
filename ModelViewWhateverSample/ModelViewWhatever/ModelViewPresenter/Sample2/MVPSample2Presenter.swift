//
//  MVPSample2Presenter.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

// Presenterの役割:
//  - 内部表現を視覚表現へ変換する
//  - 状態に適したアクションの振り分け
//  - アクションの結果/途中経過を受け取る
class MVPSample2Presenter {

    private weak var starModel: DelayStarModel?
    private weak var navigationModel: NavigationRequestModel?
    private let view: MVPSample2ViewHandler

    init(
        interchange models: (
            starModel: DelayStarModel,
            navigationModel: NavigationRequestModel
        ),
        willUpdate view: MVPSample2ViewHandler
    ) {
        self.starModel = models.starModel
        self.navigationModel = models.navigationModel
        self.view = view

        self.starModel?.append(receiver: self)
        self.navigationModel?.append(receiver: self)
    }

}

extension MVPSample2Presenter: MVPSampleRootViewDelegate, MVPSample2ViewHandlerDelegate {
 
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
        guard let model = self.starModel else {
            return
        }

        // 現在の Model の状態による分岐処理
        switch model.state {
        case .sleeping(current: .star), .processing(next: .star):
            model.unstar()
        case .sleeping(current: .unstar), .processing(next: .unstar):
            model.star()
        }
    }

    func didRequestForceNavigate() {
        self.navigationModel?.requestToNavigate()
        self.starModel?.star()
    }

    private func update(by state: DelayStarModel.State) {
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
    func receive(starState: DelayStarModel.State) {
        self.update(by: starState)
    }
}

extension MVPSample2Presenter: NavigationRequestModelReceiver {
    func receive(requestState: NavigationRequestModel.State) {
        switch requestState {
        case .nothing:
            return
        case .requested:
            guard let model = self.starModel else {
                return
            }
            self.view.navigate(with: model)
        }
    }
}
