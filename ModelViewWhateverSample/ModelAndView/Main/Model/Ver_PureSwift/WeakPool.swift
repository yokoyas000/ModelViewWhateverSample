//
//  WeakPool.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/11.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

// Weakを配列で持ってもいいが、そうするとStarModel.receiversが増え続ける問題があるので、
// append()時に掃除してくれる型を作成
class WeekPool<T: AnyObject> {
    private (set) var weaks: [Weak<T>] = []

    func append(_ element: T) {
        self.creanUp()
        self.weaks.append(Weak(element))
    }

    func forEach(_ body: (T) -> Void) {
        self.weaks.forEach{ weak in
            guard let value = weak.value else {
                return
            }
            body(value)
        }
    }

    // Weak.value が nil になっているものは外す
    private func creanUp() {
        self.weaks = self.weaks.filter { $0.value != nil }
    }

}
