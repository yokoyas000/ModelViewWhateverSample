//
//  DelayStarModel.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/13.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import Foundation

protocol DelayStarModelReceiver: class {
    func receive(starState: DelayStarModel.State)
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
            // 何もしない
            return
        case .sleeping(current: .star):
            // 現在の状態と同じなら再通知する
            self.state = .sleeping(current: .star)
        case .sleeping(current: .unstar):
            break
        }
        self.state = .processing(next: .star)

        // 状態の変更、外部への通知までにタイムラグがある
        DispatchQueue.global(qos: .default).async { [weak self] in
            sleep(UInt32(5.0))

            DispatchQueue.main.async {
                self?.state = .sleeping(current: .star)
            }
        }
    }

    func unstar() {
        switch self.state {
        case .processing:
            // 何もしない
            return
        case .sleeping(current: .unstar):
            // 現在の状態と同じなら再通知する
            self.state = .sleeping(current: .unstar)
        case .sleeping(current: .star):
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
        receiver.receive(starState: self.state)
    }

    private func notify() {
        self.receiveers.forEach { receiver in
            receiver.receive(starState: self.state)
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
