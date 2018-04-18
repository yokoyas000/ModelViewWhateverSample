//
//  MVCSample2PassiveViewProtocol.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/18.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

/// PassiveViewの役割:
/// - 内部表現を視覚表現へ変換する
protocol MVCSample2PassiveViewProtocol {
    func navigate(with model: DelayStarModelProtocol)
    func present(alert: UIAlertController)
    func update(by starState: DelayStarModelState)
}

