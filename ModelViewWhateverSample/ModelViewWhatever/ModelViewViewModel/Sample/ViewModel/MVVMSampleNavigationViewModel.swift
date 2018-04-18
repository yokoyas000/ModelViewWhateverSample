//
//  MVVMSampleViewPresenter.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/15.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

class MVVMSampleNavigationViewModel: MVVMSampleNavigationViewModelInput {

    typealias Dependency = (
        starModel: DelayStarModelProtocol,
        navigator: NavigatorProtocol,
        modalPresenter: ModalPresenter
    )

    private let dependency: Dependency
    private weak var navigationModel: NavigationRequestModelProtocol?

    init(
        dependency: Dependency,
        observe navigationModel: NavigationRequestModelProtocol
    ) {
        self.dependency = dependency
        self.navigationModel = navigationModel

        self.navigationModel?.append(receiver: self)
    }

}

extension MVVMSampleNavigationViewModel: MVVMSampleRootViewNavigationOutput {

    func didTapnavigationButton() {
        switch self.dependency.starModel.state {
        case .sleeping(current: .star):
            self.dependency.navigator.navigate(
                to: SyncStarViewController(model: self.dependency.starModel)
            )
        case .sleeping(current: .unstar), .processing:
            self.dependency.modalPresenter.present(
                to: self.createNavigateAlert()
            )
        }
    }

    private func createNavigateAlert() -> UIAlertController {
        let alert = UIAlertController(title: "", message: "★にしないと遷移できません。", preferredStyle: .alert)
        let navigate = UIAlertAction(
            title: "無視して遷移する",
            style: .default
        ) { [weak self] _ in
            self?.navigationModel?.requestToNavigate()
            self?.dependency.starModel.star()
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

extension MVVMSampleNavigationViewModel: NavigationRequestModelReceiver {
    func receive(requestState: NavigationRequestModelState) {
        switch requestState {
        case .haveNeverRequest, .notReady:
            return
        case .ready:
            self.dependency.navigator.navigate(
                to: SyncStarViewController(model: self.dependency.starModel)
            )
        }
    }
}
