//
//  StarModel3.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/13.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

protocol StarModelReceiver3: AnyObject {
    func receive(isStar: Bool)
}

// 型宣言部で Generics を使うと AnyXxxx しないでも動く
class StarModel3<T: StarModelReceiver3> {

    private var isStar: Bool

    // - WeakPool型で持つ
    private var receiveers = WeekPool<T>()

    init(initialStar: Bool) {
        self.isStar = initialStar
    }

    func toggleStar() {
        self.isStar = !self.isStar

        self.notify()
    }

    func append(receiver: T) {
        self.receiveers.append(receiver)
        receiver.receive(isStar: self.isStar)
    }

    private func notify() {
        self.receiveers.forEach { receiver in
            receiver.receive(isStar: self.isStar)
        }
    }
}
