//
//  MVPSample1ViewHandler.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

// Viewの役割:
//  - 画面の構築/表示
//  - UI要素とアクションの接続
//  - 内部表現を視覚表現へ変換する
//  - アクションの結果/途中経過を受け取る
protocol MVPSample1ViewHandlerDelegate: class {
    func didRequestForceNavigate()
}

class MVPSample1ViewHandler {

    private let navigationButton: UIButton
    private let starButton: UIButton
    private weak var starModel: DelayStarModelProtocol?
    private weak var navigationModel: NavigationRequestModel?
    private let navigator: NavigatorContract
    private let modalPresenter: ModalPresenterContract
    weak var delegate: MVPSample1ViewHandlerDelegate?

    init(
        handle: (
            starButton: UIButton,
            navigationButton: UIButton
        ),
        observe models:(
            starModel: DelayStarModelProtocol,
            navigationModel: NavigationRequestModel
        ),
        navigateBy navigator: NavigatorContract,
        presentBy modalPresenter: ModalPresenterContract
    ) {
        self.starButton = handle.starButton
        self.navigationButton = handle.navigationButton
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

    func alertForNavigation() {
        self.modalPresenter.present(to: self.createNavigateAlert())
    }

    private func createNavigateAlert() -> UIAlertController {
        let alert = UIAlertController(title: "", message: "★にしないと遷移できません。", preferredStyle: .alert)
        let navigate = UIAlertAction(
            title: "★にして遷移する",
            style: .default
        ) { [weak self] _ in
            self?.delegate?.didRequestForceNavigate()
        }

        let cancel = UIAlertAction(
            title: "OK",
            style: .cancel
        )

        alert.addAction(navigate)
        alert.addAction(cancel)

        return alert
    }
}

extension MVPSample1ViewHandler: DelayStarModelReceiver {

    // Modelの変更を画面へ反映する
    func receive(starState: DelayStarModelState) {
        switch starState {
        case .processing(next: .star):
            self.starButton.setTitle("★", for: .normal)
            self.starButton.setTitleColor(.darkGray, for: .normal)
        case .processing(next: .unstar):
            self.starButton.setTitle("☆", for: .normal)
            self.starButton.setTitleColor(.darkGray, for: .normal)
        case .sleeping(current: .star):
            self.starButton.setTitle("★", for: .normal)
            self.starButton.setTitleColor(.red, for: .normal)
        case .sleeping(current: .unstar):
            self.starButton.setTitle("☆", for: .normal)
            self.starButton.setTitleColor(.red, for: .normal)
        }
    }
}

extension MVPSample1ViewHandler: NavigationRequestModelReceiver {
    func receive(requestState: NavigationRequestModel.State) {
        switch requestState {
        case .nothing:
            return
        case .requested:
            self.navigate()
        }
    }
}
