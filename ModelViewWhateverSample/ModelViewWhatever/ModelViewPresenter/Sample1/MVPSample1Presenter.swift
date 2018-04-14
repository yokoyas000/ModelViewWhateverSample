//
//  MVPSample1Presenter.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

class MVPSample1Presenter {

    private let model: StarModel
    weak var view: MVPSample1ViewHandler?

    init(
        willCommand model: StarModel
    ) {
        self.model = model
    }

    @objc func didTapNavigateButton() {
        // 現在の状態による分岐
        if self.model.isStar {
            self.navigate()
        } else {
            self.view?.alert()
        }
    }

    @objc func didTapStarButton() {
        // Modelへ指示を行う
        self.model.toggleStar()
    }

    func didTapAlertAction() {
        self.navigate()
    }

    private func navigate() {
        guard let vc = SubViewController.create(model: self.model) else {
            return
        }
        self.view?.navigate(to: vc)
    }


}
