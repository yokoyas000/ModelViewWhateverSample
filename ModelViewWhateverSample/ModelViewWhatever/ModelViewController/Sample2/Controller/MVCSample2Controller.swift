//
//  MVCSample2Controller.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

class MVCSample2Controller: MVCSample2ControllerProtocol {

    private let starModel: DelayStarModelProtocol
    private let navigationModel: NavigationRequestModelProtocol
    private let view: MVCSample2PassiveViewProtocol
    private lazy var starModelReceiver: AnyDelayStarModelReceiver = {
        AnyDelayStarModelReceiver(self)
    }()

    init(
        reactTo handle: (
            starButton: UIButton,
            navigationButton: UIButton
        ),
        interchange models: (
            starModel: DelayStarModelProtocol,
            navigationModel: NavigationRequestModelProtocol
        ),
        update view: MVCSample2PassiveViewProtocol
    ) {
        self.starModel = models.starModel
        self.navigationModel = models.navigationModel
        self.view = view

        // Modelの監視を開始する
        self.starModel.append(receiver: self.starModelReceiver)
        self.navigationModel.append(receiver: self)

        // ユーザー動作の受付
        handle.navigationButton.addTarget(
            self,
            action: #selector(MVCSample2Controller.didTapnavigationButton),
            for: .touchUpInside
        )
        handle.starButton.addTarget(
            self,
            action: #selector(MVCSample2Controller.didTapStarButton),
            for: .touchUpInside
        )
    }

    @objc private func didTapnavigationButton() {
        // 現在の Model の状態による分岐処理
        switch self.starModel.state {
        case .sleeping(current: .star):
            self.view.navigate(with: self.starModel)
        case .sleeping(current: .unstar), .processing:
            self.view.present(
                alert: self.createNavigateAlert()
            )
        }
    }

    @objc private func didTapStarButton() {
        self.starModel.toggleStar()
    }

    private func createNavigateAlert() -> UIAlertController {
        let alert = UIAlertController(title: "", message: "★にしないと遷移できません。", preferredStyle: .alert)
        let navigate = UIAlertAction(
            title: "★にして遷移する",
            style: .default
        ) { [weak self] _ in
            self?.navigationModel.requestToNavigate()
            self?.starModel.star()
        }

        let cancel = UIAlertAction(
            title: "OK",
            style: .cancel
        )

        alert.addAction(navigate)
        alert.addAction(cancel)

        // 画面への反映は View が行う
        return alert
    }

}

extension MVCSample2Controller: DelayStarModelReceiver {
    func receive(starState: DelayStarModelState) {
        switch starState {
        case .processing(next: .star):
            self.view.update(
                star: "★",
                starColor: .darkGray,
                isStarButtonEnable: false,
                isNavigationButtonEnable: false
            )
        case .processing(next: .unstar):
            self.view.update(
                star: "☆",
                starColor: .darkGray,
                isStarButtonEnable: false,
                isNavigationButtonEnable: false
            )
        case .sleeping(current: .star):self.view.update(
            star: "★",
            starColor: .red,
            isStarButtonEnable: true,
            isNavigationButtonEnable: true
            )
        case .sleeping(current: .unstar):
            self.view.update(
                star: "☆",
                starColor: .red,
                isStarButtonEnable: true,
                isNavigationButtonEnable: true
            )
        }
    }
}

extension MVCSample2Controller: NavigationRequestModelReceiver {
    func receive(requestState: NavigationRequestModelState) {
        switch requestState {
        case .haveNeverRequest, .notReady:
            return
        case .ready:
            self.view.navigate(with: self.starModel)
        }
    }
}

