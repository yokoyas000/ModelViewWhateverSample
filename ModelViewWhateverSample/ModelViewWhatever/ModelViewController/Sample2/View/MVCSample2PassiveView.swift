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

    func update(by starState: DelayStarModelState) {
        switch starState {
        case .processing(next: .star):
            self.views.starButton.setTitle("★", for: .normal)
            self.views.starButton.setTitleColor(.darkGray, for: .normal)
            self.views.starButton.isEnabled = false
        case .processing(next: .unstar):
            self.views.starButton.setTitle("☆", for: .normal)
            self.views.starButton.setTitleColor(.darkGray, for: .normal)
            self.views.starButton.isEnabled = false
        case .sleeping(current: .star):
            self.views.starButton.setTitle("★", for: .normal)
            self.views.starButton.setTitleColor(.red, for: .normal)
            self.views.starButton.isEnabled = true
        case .sleeping(current: .unstar):
            self.views.starButton.setTitle("☆", for: .normal)
            self.views.starButton.setTitleColor(.red, for: .normal)
            self.views.starButton.isEnabled = true
        }
    }

}
