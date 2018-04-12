//
//  MVPSample1ViewHandler.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

class MVPSample1ViewHandler {

    private let transitionButton: UIButton
    private let starButton: UIButton
    private let model: StarModel
    private let presenter: MVPSample1Presenter

    init(
        handle: (
            starButton: UIButton,
            transitionButton: UIButton
        ),
        willNotify presenter: MVPSample1Presenter,
        observe model: StarModel
    ) {
        self.starButton = handle.starButton
        self.transitionButton = handle.transitionButton
        self.presenter = presenter
        self.model = model

        self.model.append(receiver: self)

        // 1. 遷移ボタンを持ち、タップされた時にSub画面へ遷移する
        self.transitionButton.addTarget(
            self.presenter,
            action: #selector(MVPSample1Presenter.navigate),
            for: .touchUpInside
        )

        // 2. Starボタンを持ち、タップされた時にModelへ指示を出す
        self.starButton.addTarget(
            self.presenter,
            action: #selector(MVPSample1Presenter.toggleStar),
            for: .touchUpInside
        )
    }

}

extension MVPSample1ViewHandler: StarModelReceiver {
    // 3. ModelからStarボタンの状態("☆/★")を取得し、表示する
    func receive(isStar: Bool) {
        let title = isStar ? "★": "☆"
        self.starButton.setTitle(title, for: .normal)
    }
}
