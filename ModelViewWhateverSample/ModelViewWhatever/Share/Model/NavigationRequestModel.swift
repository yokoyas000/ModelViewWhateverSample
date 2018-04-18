//
//  NavigationRequestModel.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/15.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

protocol NavigationRequestModelReceiver: class {
    func receive(requestState: NavigationRequestModel.State)
}

class NavigationRequestModel {

    enum State {
        case nothing
        case requested
    }

    private var state: State
    private var receiver: NavigationRequestModelReceiver?

    init(
        initialNavigationRequest state: State,
        observe model: DelayStarModelProtocol
    ) {
        self.state = state

        model.append(receiver: self)
    }

    func requestToNavigate() {
        self.state = .requested
    }

    func append(receiver: NavigationRequestModelReceiver) {
        self.receiver = receiver
        receiver.receive(requestState: self.state)
    }

}

extension NavigationRequestModel: DelayStarModelReceiver {
    func receive(starState: DelayStarModelState) {
        guard self.state == .requested else {
            return
        }

        switch starState {
        case .processing,
             .sleeping(current: .unstar):
            return

        case .sleeping(current: .star):
            self.receiver?.receive(requestState: self.state)
            self.state = .nothing
        }
    }
}
