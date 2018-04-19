//
//  DelayStarModelProtocol.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/18.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

/// Modelの役割:
protocol DelayStarModelProtocol: class {
    // - 状態・値を持つ
    var state: DelayStarModelState { get }

    // - Modelの外から指示を受け処理を行う
    func toggleStar()
    func star()

    // - 状態・値の変化をModelの外へ **間接的に** 知らせる機能持つ
    func append(receiver: AnyDelayStarModelReceiver)
}

/// Model の変更を受け取るためのプロトコル
protocol DelayStarModelReceiver: class {
    func receive(starState: DelayStarModelState)
}

/// Modelが取りうる状態
enum DelayStarModelState {
    // 指示待ち
    case sleeping(current: StarMode)

    // 処理中
    case processing(next: StarMode)

    enum StarMode {
        case star
        case unstar
    }
}
