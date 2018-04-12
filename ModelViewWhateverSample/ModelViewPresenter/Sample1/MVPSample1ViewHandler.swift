//
//  MVPSample1ViewHandler.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

class MVPSample1ViewHandler {

    private let navigateButton: UIButton
    private let starButton: UIButton
    private let model: StarModel
    private let presenter: MVPSample1Presenter
    private let navigator: NavigatorContract
    private let modalPresenter: ModalPresenterContract

    init(
        handle: (
            starButton: UIButton,
            navigateButton: UIButton
        ),
        willNotify presenter: MVPSample1Presenter,
        observe model: StarModel,
        navigateBy navigator: NavigatorContract,
        presentBy modalPresenter: ModalPresenterContract
    ) {
        self.starButton = handle.starButton
        self.navigateButton = handle.navigateButton
        self.presenter = presenter
        self.model = model
        self.navigator = navigator
        self.modalPresenter = modalPresenter

        self.presenter.view = self
        self.model.append(receiver: self)

        // 1. 遷移ボタンを持ち、タップされた時にSub画面へ遷移する
        self.navigateButton.addTarget(
            self.presenter,
            action: #selector(MVPSample1Presenter.didTapNavigateButton),
            for: .touchUpInside
        )

        // 2. Starボタンを持ち、タップされた時にModelへ指示を出す
        self.starButton.addTarget(
            self.presenter,
            action: #selector(MVPSample1Presenter.didTapStarButton),
            for: .touchUpInside
        )
    }

    func navigate(to next: UIViewController) {
        self.navigator.navigate(to: next)
    }

    func alert(_ alert: UIAlertController) {
        self.modalPresenter.present(to: alert)
    }

}

extension MVPSample1ViewHandler: StarModelReceiver {
    // 3. ModelからStarボタンの状態("☆/★")を取得し、表示する
    func receive(isStar: Bool) {
        let title = isStar ? "★": "☆"
        self.starButton.setTitle(title, for: .normal)
    }
}
