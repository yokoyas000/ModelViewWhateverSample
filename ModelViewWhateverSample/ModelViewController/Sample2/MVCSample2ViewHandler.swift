//
//  MVCSample2ViewHandler.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit
class MVCSample2ViewHandler {

    private let starButton: UIButton
    private let navigator: NavigatorContract

    init(
        willUpdate starButton: UIButton,
        navigateBy navigator: NavigatorContract
    ) {
        self.starButton = starButton
        self.navigator = navigator
    }

    func navigate(with model: StarModel) {
        guard let vc = SubViewController.create(model: model) else {
            return
        }

        self.navigator.navigate(to: vc)
    }

    func update(star: Bool) {
        let title = star ? "★": "☆"
        self.starButton.setTitle(title, for: .normal)
    }

}
