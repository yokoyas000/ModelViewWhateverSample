//
//  MVCSample2ControllerProtocol.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/18.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

/// Controllerの役割:
///  - アクションの結果/途中経過を受け取る
///  - ユーザー操作の受付
///  - アクションを定義する
protocol MVCSample2ControllerProtocol: DelayStarModelReceiver, NavigationRequestModelReceiver {}
