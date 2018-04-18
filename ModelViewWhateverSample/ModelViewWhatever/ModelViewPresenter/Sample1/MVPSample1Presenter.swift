//
//  MVPSample1Presenter.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

// Presenterの役割:
// - 状態に適したアクションの振り分け
class MVPSample1Presenter {

    private let starModel: DelayStarModelProtocol
    private let navigationModel: NavigationRequestModel
    private let view: MVPSample1ViewHandler

    init(
        willCommand models:(
            starModel: DelayStarModelProtocol,
            navigationModel: NavigationRequestModel
        ),
        and view: MVPSample1ViewHandler
    ) {
        self.starModel = models.starModel
        self.navigationModel = models.navigationModel
        self.view = view
    }

}

extension MVPSample1Presenter: MVPSampleRootViewDelegate, MVPSample1ViewHandlerDelegate {

    @objc func didTapnavigationButton() {
        // 現在の Model の状態による分岐処理
        switch self.starModel.state {
        case .sleeping(current: .star):
            self.view.navigate()
        case .sleeping(current: .unstar), .processing:
            self.view.alertForNavigation()
        }
    }

    @objc func didTapStarButton() {
        self.starModel.toggleStar()
    }

    func didRequestForceNavigate() {
        self.navigationModel.requestToNavigate()
        self.starModel.star()
    }

}
