//
//  MVPSample2PresenterProtocol.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/18.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

/// Presenterの役割:
///  - 状態に適したアクションの振り分け
///  - アクションの結果/途中経過を受け取る
protocol MVPSample2PresenterProtocol
    : MVPSampleRootViewDelegate, MVPSample2InteractiveViewDelegate,
DelayStarModelReceiver, NavigationRequestModelReceiver {}
