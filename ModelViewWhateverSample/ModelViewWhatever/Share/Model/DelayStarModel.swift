//
//  DelayStarModel.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/13.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import Foundation

/// Model本体
class DelayStarModel: DelayStarModelProtocol {

    private var receiveers: [DelayStarModelReceiver] = []
    private(set) var state: DelayStarModelState {
        didSet {
            self.notify()
        }
    }

    init(initialState: DelayStarModelState) {
        self.state = initialState
    }

    func toggleStar() {
        switch self.state {
        case .processing:
            // 何もしない
            return
        case .sleeping(current: .star):
            self.state = .processing(next: .unstar)
            self.unstarImpl()
        case .sleeping(current: .unstar):
            self.state = .processing(next: .star)
            self.starImpl()
        }
    }

    func star() {
        switch self.state {
        case .processing:
            // 何もしない
            return
        case .sleeping(current: .star):
            // 現在の状態と同じなら再通知する
            self.state = .sleeping(current: .star)
            return
        case .sleeping(current: .unstar):
            self.state = .processing(next: .star)
            self.starImpl()
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
            self.state = .processing(next: .unstar)
            self.unstarImpl()
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

    private func starImpl() {
        // 状態の変更、外部への通知までにタイムラグがある
        DispatchQueue.global(qos: .default).async { [weak self] in
            sleep(UInt32(3.0))

            DispatchQueue.main.async {
                self?.state = .sleeping(current: .star)
            }
        }
    }

    private func unstarImpl() {
        // 状態の変更、外部への通知までにタイムラグがある
        DispatchQueue.global(qos: .default).async { [weak self] in
            sleep(UInt32(2.0))

            DispatchQueue.main.async {
                self?.state = .sleeping(current: .unstar)
            }
        }
    }

}
