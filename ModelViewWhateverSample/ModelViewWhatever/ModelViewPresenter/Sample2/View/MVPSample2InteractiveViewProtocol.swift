//
//  MVPSample2InteractiveViewProtocol.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/18.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

/// InteractiveViewの役割:
///  - ユーザー操作の受付
///  - 内部表現を視覚表現へ変換する
protocol MVPSample2InteractiveViewProtocol {
    var delegate: MVPSample2InteractiveViewDelegate? { get set }
    func update(star: String, starColor: UIColor, isStarButtonEnable: Bool, isNavigationButtonEnable: Bool)
    func navigate(with: DelayStarModelProtocol)
    func alertForNavigation()
}

protocol MVPSample2InteractiveViewDelegate: class {
    func didRequestForceNavigate()
}
