//
//  MVPSample2InteractiveViewProtocol.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/18.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

/// InteractiveViewの役割:
///  - ユーザー操作の受付
protocol MVPSample2InteractiveViewProtocol {
    var delegate: MVPSample2InteractiveViewDelegate? { get set }
}

protocol MVPSample2InteractiveViewDelegate: class {
    func didRequestForceNavigate()
}
