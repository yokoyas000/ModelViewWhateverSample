//
//  MVPSample2Presenter.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import Foundation

protocol MVPSample2PresenterDelegate: class {
    func navigate(next viewController: SubViewController)
    func update(starTitle: String)
}

class MVPSample2Presenter {

    private let model: StarModel
    private weak var delegate: MVPSample2PresenterDelegate?

    init(
        interchange model: StarModel
    ) {
        self.model = model
    }

    func append(delegate: MVPSample2PresenterDelegate) {
        self.delegate = delegate
        self.model.append(receiver: self)
    }

    @objc func navigate() {
        guard let vc = SubViewController.create(model: model) else {
            return
        }
        self.delegate?.navigate(next: vc)
    }

    @objc func toggleStar() {
        self.model.toggleStar()
    }
}

extension MVPSample2Presenter: StarModelReceiver {
    func receive(isStar: Bool) {
        let title = isStar ? "★": "☆"
        self.delegate?.update(starTitle: title)
    }
}
