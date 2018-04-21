//
//  MVPSample2InteractiveView.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

class MVPSample2InteractiveView: MVPSample2InteractiveViewProtocol {

    typealias Views = (
        starButton: UIButton,
        navigationButton: UIButton,
        navigator: NavigatorProtocol,
        modalPresenter: ModalPresenterProtocol
    )

    private let views: Views
    weak var delegate: MVPSample2InteractiveViewDelegate?

    init(
        handle views: Views
    ) {
        self.views = views
    }

    func navigate(with model: DelayStarModelProtocol) {
        self.views.navigator.navigate(
            to: SyncStarViewController(model: model)
        )
    }

    func update(
        star: String,
        starColor: UIColor,
        isStarButtonEnable: Bool,
        isNavigationButtonEnable: Bool
    ) {
        self.views.starButton.setTitle(star, for: .normal)
        self.views.starButton.setTitleColor(starColor, for: .normal)
        self.views.starButton.isEnabled = isStarButtonEnable
        self.views.navigationButton.isEnabled = isNavigationButtonEnable
    }

    func alertForNavigation() {
        self.views.modalPresenter.present(
            to: self.createNavigateAlert()
        )
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
