//
//  AnyDelayStarModelReceiver.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/19.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

final class AnyDelayStarModelReceiver: DelayStarModelReceiver {

    private weak var value: DelayStarModelReceiver?

    init(_ value: DelayStarModelReceiver) {
        self.value = value
    }

    func receive(starState: DelayStarModelState) {
        self.value?.receive(starState: starState)
    }

}
