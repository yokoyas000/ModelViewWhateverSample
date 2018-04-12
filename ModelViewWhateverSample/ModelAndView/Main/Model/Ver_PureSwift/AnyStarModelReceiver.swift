//
//  AnyStarModelReceiver.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/11.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

// 本来は Weak<StarModelReceiver2> としたいが、
// [エラーがでてつらいので](https://stackoverflow.com/questions/32807948/using-as-a-concrete-type-conforming-to-protocol-anyobject-is-not-supported)
// AnyStarModelReceiver を定義し、 Weak<AnyStarModelReceiver> とすることで頑張る
class AnyStarModelReceiver: StarModelReceiver2 {

    private let _receive: (Bool) -> Void

    init(_ receiver: StarModelReceiver2) {
        self._receive = { [weak receiver] isStar in
            receiver?.receive(isStar: isStar)
        }
    }

    func receive(isStar: Bool) {
        return self._receive(isStar)
    }
}
