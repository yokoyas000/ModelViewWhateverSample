//
//  MVPSample1InteractiveView.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//
import UIKit

class MVPSample1InteractiveView: MVPSample1InteractiveViewProtocol {

    typealias Views = (
        starButton: UIButton,
        navigationButton: UIButton,
        navigator: NavigatorProtocol,
        modalPresenter: ModalPresenterProtocol
    )
    typealias Dependency = DelayStarModelProtocol

    private let views: Views
    private let dependency: Dependency
    private lazy var starModelReceiver: AnyDelayStarModelReceiver = {
        AnyDelayStarModelReceiver(self)
    }()

    weak var delegate: MVPSample1InteractiveViewDelegate?

    init(
        handle views: Views,
        dependency: Dependency,
        observe models:(
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
            to: SyncStarViewController(model: self.dependency)
        )
    }

    func alertForNavigation() {
        self.views.modalPresenter.present(to: self.createNavigateAlert())
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

extension MVPSample1InteractiveView: DelayStarModelReceiver {
    func receive(starState: DelayStarModelState) {
        switch starState {
        case .processing(next: .star):
            self.views.starButton.setTitle("★", for: .normal)
            self.views.starButton.setTitleColor(.darkGray, for: .normal)
            self.views.starButton.isEnabled = false
            self.views.navigationButton.isEnabled = false
        case .processing(next: .unstar):
            self.views.starButton.setTitle("☆", for: .normal)
            self.views.starButton.setTitleColor(.darkGray, for: .normal)
            self.views.starButton.isEnabled = false
            self.views.navigationButton.isEnabled = false

        case .sleeping(current: .star):
            self.views.starButton.setTitle("★", for: .normal)
            self.views.starButton.setTitleColor(.red, for: .normal)
            self.views.starButton.isEnabled = true
            self.views.navigationButton.isEnabled = true

        case .sleeping(current: .unstar):
            self.views.starButton.setTitle("☆", for: .normal)
            self.views.starButton.setTitleColor(.red, for: .normal)
            self.views.starButton.isEnabled = true
            self.views.navigationButton.isEnabled = true

        }
    }
}

extension MVPSample1InteractiveView: NavigationRequestModelReceiver {
    func receive(requestState: NavigationRequestModelState) {
        switch requestState {
        case .haveNeverRequest, .notReady:
            return
        case .ready:
            self.navigate()
        }
    }
}
