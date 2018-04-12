//
//  MVCSample1ViewHandler.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

// Updater
// 表示に注力してる
// 反映する
class MVCSample1ViewHandler {

    private let starButton: UIButton
    private let model: StarModel

    init(
        willUpdate starButton: UIButton,
        observe model: StarModel
    ) {
        self.starButton = starButton
        self.model = model

        // Modelの監視を開始する
        self.model.append(receiver: self)
    }
}

extension MVCSample1ViewHandler: StarModelReceiver {

    // 3. ModelからStarボタンの状態("☆/★")を取得し、表示する
    func receive(isStar: Bool) {
        let title = isStar ? "★": "☆"
        self.starButton.setTitle(title, for: .normal)
    }
}
