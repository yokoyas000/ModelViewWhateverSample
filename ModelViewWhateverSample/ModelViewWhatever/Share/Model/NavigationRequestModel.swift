//
//  NavigationRequestModel.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/15.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

class NavigationRequestModel: NavigationRequestModelProtocol {

    private(set) var state: NavigationRequestModelState {
        didSet {
            self.receiver?.receive(requestState: self.state)
        }
    }
    private var receiver: NavigationRequestModelReceiver?

    init(
        observe model: DelayStarModelProtocol
    ) {
        self.state = .haveNeverRequest
        model.append(receiver: self)
    }

    func requestToNavigate() {
        self.state = .notReady
    }

    func append(receiver: NavigationRequestModelReceiver) {
        self.receiver = receiver
        receiver.receive(requestState: self.state)
    }

}

extension NavigationRequestModel: DelayStarModelReceiver {
    func receive(starState: DelayStarModelState) {
        guard self.state == .notReady else {
            return
        }

        switch starState {
        case .processing,
             .sleeping(current: .unstar):
            return

        case .sleeping(current: .star):
            self.state = .ready
        }
    }
}
