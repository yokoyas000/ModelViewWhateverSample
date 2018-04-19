//
//  MVPSample1InteractiveView.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//
import UIKit

class MVPSample1InteractiveView: MVPSample1InteractiveViewProtocol {

    private let navigationButton: UIButton
    private let starButton: UIButton
    private let starModel: DelayStarModelProtocol
    private let navigationModel: NavigationRequestModelProtocol
    private let navigator: NavigatorProtocol
    private let modalPresenter: ModalPresenterContract
    private lazy var starModelReceiver: AnyDelayStarModelReceiver = {
        AnyDelayStarModelReceiver(self)
    }()
    weak var delegate: MVPSample1InteractiveViewDelegate?

    init(
        handle: (
            starButton: UIButton,
            navigationButton: UIButton
        ),
        observe models:(
            starModel: DelayStarModelProtocol,
            navigationModel: NavigationRequestModelProtocol
        ),
        navigateBy navigator: NavigatorProtocol,
        presentBy modalPresenter: ModalPresenterContract
    ) {
        self.starButton = handle.starButton
        self.navigationButton = handle.navigationButton
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

    // - MARK: DelayStarModelReceiver

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

    // - MARK: NavigationRequestModelReceiver

    func receive(requestState: NavigationRequestModelState) {
        switch requestState {
        case .haveNeverRequest, .notReady:
            return
        case .ready:
            self.navigate()
        }
    }
}
