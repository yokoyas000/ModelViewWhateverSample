//
//  MVPSample2Presenter.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

// Presenter -> View への値の受  け渡しは
// 直接的方法(Presenter が View を知っている)ではなく、
// 間接的方法(この場合 Observer パターン)を利用する
protocol MVPSample2PresenterReceiver: class {
    func navigate(to next: UIViewController)
    func update(starTitle: String, navigateEnable: Bool)
    func alert()
}

class MVPSample2Presenter {

    private let model: StarModel
    private weak var receiver: MVPSample2PresenterReceiver?

    init(
        interchange model: StarModel
    ) {
        self.model = model
    }

    func connect(receiver: MVPSample2PresenterReceiver) {
        self.receiver = receiver
        self.model.append(receiver: self)
    }

    @objc func didTapNavigateButton() {
        // 現在の状態による分岐
        if self.model.isStar {
            self.navigate()
        } else {
            self.receiver?.alert()
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
        self.receiver?.navigate(to: vc)
    }

}

extension MVPSample2Presenter: StarModelReceiver {
    func receive(isStar: Bool) {
        let title = isStar ? "★": "☆"
        self.receiver?.update(starTitle: title, navigateEnable: isStar)
    }
}
