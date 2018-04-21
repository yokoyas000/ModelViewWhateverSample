//
//  MVVMSampleStarViewModelInOut.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/18.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

/// ViewModelの役割:
///  - アクションを定義する
///  - アクションの結果/途中経過を受け取る
protocol MVVMSampleStarViewModelInput: DelayStarModelReceiver {
    var output: MVVMSampleStarViewModelOutput? { get set }
    func didTapStarButton()
}

protocol MVVMSampleStarViewModelOutput: class {
    var title: String? { get set }
    var color: UIColor? { get set }
    var isEnable: Bool { get set }
}
