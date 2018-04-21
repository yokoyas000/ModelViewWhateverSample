//
//  MVCSample2PassiveView.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

class MVCSample2PassiveView: MVCSample2PassiveViewProtocol {

    typealias Views = (
        starButton: UIButton,
        navigationButton: UIButton,
        navigator: NavigatorProtocol,
        modalPresenter: ModalPresenterProtocol
    )

    private let views: Views

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

    func present(alert: UIAlertController) {
        self.views.modalPresenter.present(to: alert)
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

}
