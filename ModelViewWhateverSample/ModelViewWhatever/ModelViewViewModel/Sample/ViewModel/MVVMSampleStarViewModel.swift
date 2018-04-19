//
//  MVVMSampleViewBinding.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/15.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

class MVVMSampleStarViewModel: MVVMSampleStarViewModelInput {

    private let starModel: DelayStarModelProtocol
    private lazy var starModelReceiver: AnyDelayStarModelReceiver = {
        AnyDelayStarModelReceiver(self)
    }()
    
    weak var output: MVVMSampleStarViewModelOutput? {
        didSet {
            self.update(by: self.starModel.state)
        }
    }

    init(
        observe starModel: DelayStarModelProtocol
    ) {
        self.starModel = starModel
        self.starModel.append(receiver: self.starModelReceiver)
    }

    private func update(by starState: DelayStarModelState) {
        switch starState {
        case .processing(next: .star):
            self.output?.title = "★"
            self.output?.color = .darkGray
            self.output?.isEnable = false
        case .processing(next: .unstar):
            self.output?.title = "☆"
            self.output?.color = .darkGray
            self.output?.isEnable = false
        case .sleeping(current: .star):
            self.output?.title = "★"
            self.output?.color = .red
            self.output?.isEnable = true
        case .sleeping(current: .unstar):
            self.output?.title = "☆"
            self.output?.color = .red
            self.output?.isEnable = true
        }
    }

    func didTapStarButton() {
        self.starModel.toggleStar()
    }
}

extension MVVMSampleStarViewModel: DelayStarModelReceiver {
    func receive(starState: DelayStarModelState) {
        self.update(by: starState)
    }
}
