//
//  MVPSample2Presenter.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

class MVPSample2Presenter {

    private let model: StarModel
    private weak var view: MVPSample2ViewHandler?

    init(
        interchange model: StarModel
    ) {
        self.model = model
    }

    func connect(view: MVPSample2ViewHandler) {
        self.view = view
        self.model.append(receiver: self)
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

extension MVPSample2Presenter: StarModelReceiver {
    func receive(isStar: Bool) {
        let title = isStar ? "★": "☆"
        self.view?.update(starTitle: title)
    }
}
