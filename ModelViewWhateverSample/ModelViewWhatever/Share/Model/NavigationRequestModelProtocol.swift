//
//  NavigationRequestModelProtocol.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/18.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

/// Modelの役割:
protocol NavigationRequestModelProtocol: class {
    // - 状態・値を持つ
    var state: NavigationRequestModelState { get }

    // - Modelの外から指示を受け処理を行う
    func requestToNavigate()

    // - 状態・値の変化をModelの外へ **間接的に** 知らせる機能持つ
    func append(receiver: NavigationRequestModelReceiver)
}

/// Model の変更を受け取るためのプロトコル
protocol NavigationRequestModelReceiver: class {
    func receive(requestState: NavigationRequestModelState)
}

/// Modelが取りうる状態
enum NavigationRequestModelState {
    case haveNeverRequest
    case notReady
    case ready
}
