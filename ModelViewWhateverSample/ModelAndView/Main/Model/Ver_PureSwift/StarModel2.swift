//
//  StarModel2.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/11.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

protocol StarModelReceiver2: AnyObject {
    func receive(isStared: Bool)
}

// - AnyXxxx への変換を楽にする
extension StarModelReceiver2 {
    func asAny() -> AnyStarModelReceiver {
        return AnyStarModelReceiver(self)
    }
}

// PureSwift で頑張るver
class StarModel2 {

    private var isStared: Bool

    // - Weak型で持つ
    private var receiveers: [Weak<AnyStarModelReceiver>] = []

    init(initialStared: Bool) {
        self.isStared = initialStared
    }

    func toggleStar() {
        self.isStared = !self.isStared

        self.notify()
    }

    func append(receiver: StarModelReceiver2) {
        self.receiveers.append(
            Weak<AnyStarModelReceiver>(
                AnyStarModelReceiver(receiver)
            )
        )
        self.notify()
    }

    private func notify() {
        self.receiveers.forEach { receiver in
            receiver.value?.receive(isStared: self.isStared)
        }
    }
}


