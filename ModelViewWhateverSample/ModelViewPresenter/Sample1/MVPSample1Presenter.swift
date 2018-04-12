//
//  MVPSample1Presenter.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import Foundation

class MVPSample1Presenter {

    private let model: StarModel
    private let navigator: NavigatorContract

    init(
        willCommand model: StarModel,
        navigateBy navigator: NavigatorContract
    ) {
        self.model = model
        self.navigator = navigator
    }

    @objc func navigate() {
        guard let vc = SubViewController.create(model: self.model) else {
            return
        }

        self.navigator.navigate(to: vc)
    }

    @objc func toggleStar() {
        self.model.toggleStar()
    }

}
