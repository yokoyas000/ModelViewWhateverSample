//
//  AnyDelayStarModelReceiver.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/13.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

class AnyWeakDelayStarModelReceiver: DelayStarModelReceiver {

    private weak var receive: DelayStarModelReceiver?

    init(_ receiver: DelayStarModelReceiver) {
        self.receive = receiver
    }

    func receive(status: DelayStarModel.State) {
        self.receive(status: status)
    }
}
