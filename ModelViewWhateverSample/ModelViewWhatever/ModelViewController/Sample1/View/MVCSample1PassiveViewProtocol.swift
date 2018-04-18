//
//  MVCSample1PassiveViewProtocol.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/18.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

/// PassiveViewの役割:
///  - アクションの結果/途中経過を受け取る
///  - 内部表現を視覚表現へ変換する
protocol MVCSample1PassiveViewProtocol: DelayStarModelReceiver, NavigationRequestModelReceiver {
    func navigate()
    func present(alert: UIAlertController)
}
