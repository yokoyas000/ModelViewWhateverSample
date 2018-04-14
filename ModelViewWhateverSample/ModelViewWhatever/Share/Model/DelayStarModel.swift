//
//  DelayStarModel.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/13.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import Foundation

protocol DelayStarModelReceiver: class {
    func receive(state: DelayStarModel.State)
}

/// 指示を受けてから状態の変更までの間にタイムラグがあるモデル
class DelayStarModel {

    private var receiveers: [DelayStarModelReceiver] = []
    private(set) var state: State {
        didSet {
            self.notify()
        }
    }

    init(initialStarMode: StarMode) {
        self.state = .sleeping(current: initialStarMode)
    }

    func star() {
        switch self.state {
        case .processing:
            return
        case .sleeping:
            break
        }
        self.state = .processing(next: .star)

        // 状態の変更、外部への通知までにタイムラグがある
        DispatchQueue.global(qos: .default).async { [weak self] in
            sleep(UInt32(2.0))

            DispatchQueue.main.async {
                self?.state = .sleeping(current: .star)
            }
        }
    }

    func unstar() {
        switch self.state {
        case .processing:
            return
        case .sleeping:
            break
        }
        self.state = .processing(next: .unstar)

        // 状態の変更、外部への通知までにタイムラグがある
        DispatchQueue.global(qos: .default).async { [weak self] in
            sleep(UInt32(2.0))

            DispatchQueue.main.async {
                self?.state = .sleeping(current: .unstar)
            }
        }
    }

    func append(receiver: DelayStarModelReceiver) {
        self.receiveers.append(receiver)
        receiver.receive(state: self.state)
    }

    private func notify() {
        self.receiveers.forEach { receiver in
            receiver.receive(state: self.state)
        }
    }
}

extension DelayStarModel {

    enum StarMode {
        case star
        case unstar
    }

    enum State {
        case sleeping(current: StarMode)
        case processing(next: StarMode)
    }
}
