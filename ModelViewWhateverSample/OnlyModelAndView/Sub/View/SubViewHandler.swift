//
//  SubViewHandler.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/10.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

class SubViewHandler {

    private let starButton: UIButton
    private let model: StarModel

    init(
        handle starButton: UIButton,
        interchange model: StarModel
    ) {
        self.starButton = starButton
        self.model = model

        self.model.append(receiver: self)

        // 1. Starボタンを持ち、タップされた時にModelへ指示を出す
        self.starButton.addTarget(
            self,
            action: #selector(SubViewHandler.didTapStarButton),
            for: .touchUpInside
        )
    }

    @objc private func didTapStarButton() {
        self.model.toggleStar()
    }

}

extension SubViewHandler: StarModelReceiver {

    func receive(isStar: Bool) {
        let title = isStar ? "★": "☆"
        self.starButton.setTitle(title, for: .normal)
    }
}
