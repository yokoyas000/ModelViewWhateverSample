//
//  MVPSample1InteractiveViewProtocol.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/18.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

/// InteractiveViewの役割:
///  - アクションの結果/途中経過を受け取る
///  - ユーザー操作の受付
///  - 内部表現を視覚表現へ変換する
protocol MVPSample1InteractiveViewProtocol: DelayStarModelReceiver, NavigationRequestModelReceiver {
    var delegate: MVPSample1InteractiveViewDelegate? { get set }

    func navigate()
    func alertForNavigation()
}

protocol MVPSample1InteractiveViewDelegate: class {
    func didRequestForceNavigate()
}
