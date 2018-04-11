//
//  MainViewHandler.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/10.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//
import UIKit

/// Main画面を表すView
class MainViewHandler {

    private let navigateToSubViewButton: UIButton
    private let starButton: UIButton
    private let model: StarModel
    private let navigator: NavigatorContract

    init(
        handle: (
            starButton: UIButton,
            navigateToSubViewButton: UIButton
        ),
        notify model: StarModel,
        navigateBy navigator: NavigatorContract
    ) {
        self.starButton = handle.starButton
        self.navigateToSubViewButton = handle.navigateToSubViewButton
        self.model = model
        self.navigator = navigator

        // Modelの監視を開始する
        self.model.append(receiver: self)

        // 1. 遷移ボタンを持ち、タップされた時にSub画面へ遷移する
        self.navigateToSubViewButton.addTarget(
            self,
            action: #selector(MainViewHandler.didTapNavigateButton),
            for: .touchUpInside
        )

        // 2. Starボタンを持ち、タップされた時にModelへ指示を出す
        self.starButton.addTarget(
            self,
            action: #selector(MainViewHandler.didTapStarButton),
            for: .touchUpInside
        )
    }

    @objc private func didTapNavigateButton() {
        guard let subVC = SubViewController.create(model: self.model) else {
            return
        }

        self.navigator.navigate(to: subVC)
    }

    @objc private func didTapStarButton() {
        self.model.toggleStar()
    }

}

extension MainViewHandler: StarModelReceiver {

    // 3. ModelからStarボタンの状態("☆/★")を取得し、表示する
    func receive(isStared: Bool) {
        let title = isStared ? "★": "☆"
        self.starButton.setTitle(title, for: .normal)
    }
}
