//
//  MVCSample1ViewHandler.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

// Viewの役割:
//  - 画面の構築/表示
//  - 内部表現を視覚表現へ変換する
//  - アクションの結果/途中経過を受け取る
class MVCSample1ViewHandler {

    private let starButton: UIButton
    private weak var starModel: DelayStarModel?
    private weak var navigationModel: NavigationRequestModel?
    private let navigator: NavigatorContract
    private let modalPresenter: ModalPresenterContract

    init(
        willUpdate starButton: UIButton,
        observe models: (
            starModel: DelayStarModel,
            navigationModel: NavigationRequestModel
        ),
        navigateBy navigator: NavigatorContract,
        presentBy modalPresenter: ModalPresenterContract
    ) {
        self.starButton = starButton
        self.starModel = models.starModel
        self.navigationModel = models.navigationModel
        self.navigator = navigator
        self.modalPresenter = modalPresenter

        // Modelの監視を開始する
        self.starModel?.append(receiver: self)
        self.navigationModel?.append(receiver: self)
    }

    func navigate() {
        guard let model = self.starModel else {
            return
        }

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
    func receive(starState: DelayStarModel.State) {
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

extension MVCSample1ViewHandler: NavigationRequestModelReceiver {
    func receive(requestState: NavigationRequestModel.State) {
        switch requestState {
        case .nothing:
            return
        case .requested:
            self.navigate()
        }
    }
}

