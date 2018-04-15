//
//  MVVMSampleViewBinding.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/15.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

// ViewModel:
//  - UI要素とアクションの接続
//  - 内部表現を視覚表現へ変換する
//  - 状態に適したアクションの振り分け
//  - アクションの結果/途中経過を受け取る
class MVVMSampleStarViewModel {

    typealias Output = (_ title: String, _ color: UIColor, _ isEnable: Bool) -> Void

    var outputStarButton: Output? {
        didSet {
            guard let state = self.starModel?.state else {
                return
            }
            self.update(by: state)
        }
    }
    private weak var starModel: DelayStarModel?

    init(
        binding input: MVVMSampleRootView,
        to starModel: DelayStarModel
    ) {
        self.starModel = starModel

        // UILabel, UIButton 等は ViewModel とみなせる
        // (xib, storyboard を View とみなす)
        self.starModel?.append(receiver: self)
        input.starButtonDelegate = self
    }

    private func update(by starState: DelayStarModel.State) {
        switch starState {
        case .processing(next: .star):
            self.outputStarButton?("★", .darkGray, false)
        case .processing(next: .unstar):
            self.outputStarButton?("☆", .darkGray, false)
        case .sleeping(current: .star):
            self.outputStarButton?("★", .red, true)
        case .sleeping(current: .unstar):
            self.outputStarButton?("☆", .red, true)
        }
    }
}

extension MVVMSampleStarViewModel: MVVMSampleRootViewStarButtonDelegate {

    func didTapStarButton() {
        guard let starModel = self.starModel else {
            return
        }

        // 現在の Model の状態による分岐処理
        switch starModel.state {
        case .sleeping(current: .star), .processing(next: .star):
            starModel.unstar()
        case .sleeping(current: .unstar), .processing(next: .unstar):
            starModel.star()
        }
    }
}

extension MVVMSampleStarViewModel: DelayStarModelReceiver {
    func receive(starState: DelayStarModel.State) {
        self.update(by: starState)
    }
}
