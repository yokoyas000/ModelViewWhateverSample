//
//  StarModel2.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/11.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

protocol StarModelReceiver2: AnyObject {
    func receive(isStar: Bool)
}

// - AnyXxxx への変換を楽にする
extension StarModelReceiver2 {
    func asAny() -> AnyStarModelReceiver {
        return AnyStarModelReceiver(self)
    }
}

// PureSwift で頑張るver
class StarModel2 {

    private var isStar: Bool

    // - WeakPool型で持つ
    private var receiveers = WeekPool<AnyStarModelReceiver>()

    init(initialStar: Bool) {
        self.isStar = initialStar
    }

    func toggleStar() {
        self.isStar = !self.isStar

        self.notify()
    }

    func append(receiver: StarModelReceiver2) {
        self.receiveers.append(receiver.asAny())
        self.notify()
    }

    private func notify() {
        self.receiveers.forEach { receiver in
            receiver.receive(isStar: self.isStar)
        }
    }
}


