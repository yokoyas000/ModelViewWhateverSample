//
//  MVPSample2ViewHandler.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

class MVPSample2ViewHandler {

    private let transitionButton: UIButton
    private let starButton: UIButton
    private let navigator: NavigatorContract
    private let presenter: MVPSample2Presenter

    init(
        handle: (
            starButton: UIButton,
            transitionButton: UIButton
        ),
        interchange presenter: MVPSample2Presenter,
        navigateBy navigator: NavigatorContract
    ) {
        self.starButton = handle.starButton
        self.transitionButton = handle.transitionButton
        self.presenter = presenter
        self.navigator = navigator

        self.presenter.append(delegate: self)

        // 1. 遷移ボタンを持ち、タップされた時にSub画面へ遷移する
        self.transitionButton.addTarget(
            self.presenter,
            action: #selector(MVPSample2Presenter.navigate),
            for: .touchUpInside
        )

        // 2. Starボタンを持ち、タップされた時にModelへ指示を出す
        self.starButton.addTarget(
            self.presenter,
            action: #selector(MVPSample2Presenter.toggleStar),
            for: .touchUpInside
        )
    }

}

extension MVPSample2ViewHandler: MVPSample2PresenterDelegate {
    func navigate(next viewController: SubViewController) {
        self.navigator.navigate(to: viewController)
    }

    func update(starTitle: String) {
        self.starButton.setTitle(starTitle, for: .normal)
    }
}
