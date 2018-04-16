//
//  MVVMSampleViewBinding.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/15.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

protocol MVVMSampleStarViewModelInput: MVVMSampleRootViewStarOutput {}
protocol MVVMSampleStarViewModelOutput: class {
    func update(title: String, color: UIColor, isEnable: Bool)
}

// ViewModel:
//  - UI要素とアクションの接続
//  - 内部表現を視覚表現へ変換する
//  - 状態に適したアクションの振り分け
//  - アクションの結果/途中経過を受け取る
class MVVMSampleStarViewModel: MVVMSampleStarViewModelInput {

    private weak var starModel: DelayStarModel?
    weak var output: MVVMSampleStarViewModelOutput?

    init(
        observe starModel: DelayStarModel
    ) {
        self.starModel = starModel
        self.starModel?.append(receiver: self)
    }

    private func update(by starState: DelayStarModel.State) {
        switch starState {
        case .processing(next: .star):
            self.output?.update(title: "★", color: .darkGray, isEnable: false)
        case .processing(next: .unstar):
            self.output?.update(title: "☆", color: .darkGray, isEnable: false)
        case .sleeping(current: .star):
            self.output?.update(title: "★", color: .red, isEnable: true)
        case .sleeping(current: .unstar):
            self.output?.update(title: "☆", color: .red, isEnable: true)
        }
    }

    func didTapStarButton() {
        self.starModel?.toggle()
    }
}

extension MVVMSampleStarViewModel: DelayStarModelReceiver {
    func receive(starState: DelayStarModel.State) {
        self.update(by: starState)
    }
}
