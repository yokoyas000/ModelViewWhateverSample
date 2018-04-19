//
//  Weak.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/11.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

final class Weak<T: AnyObject> {
    // 弱参照
    private(set) weak var value: T?

    init(_ value: T) {
        self.value = value
    }
}
