//
//  StarModel.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/10.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import Foundation

@objc
protocol StarModelReceiver {
    func receive(isStared: Bool)
}

/// Starボタンの状態を持つModel
class StarModel {

    private var isStared: Bool
    private var receiveers = NSHashTable<StarModelReceiver>.weakObjects()

    init(initialStared: Bool) {
        self.isStared = initialStared
    }

    // 2. Viewから指示を受け、状態("☆/★")を変更する
    func toggleStar() {
        self.isStared = !self.isStared

        // 3. 指示の結果、状態("☆/★")が何であるかをViewへ知らせる
        self.notify()
    }

    func append(receiver: StarModelReceiver) {
        self.receiveers.add(receiver)
        self.notify()
    }

    private func notify() {
        self.receiveers.allObjects.forEach { receiver in
            receiver.receive(isStared: self.isStared)
        }
    }
}
