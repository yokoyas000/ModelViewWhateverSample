//
//  MVPSample1Presenter.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

class MVPSample1Presenter: MVPSample1PresenterProtocol {

    private let starModel: DelayStarModelProtocol
    private let navigationModel: NavigationRequestModelProtocol
    private let view: MVPSample1InteractiveViewProtocol

    init(
        willCommand models:(
            starModel: DelayStarModelProtocol,
            navigationModel: NavigationRequestModelProtocol
        ),
        and view: MVPSample1InteractiveViewProtocol
    ) {
        self.starModel = models.starModel
        self.navigationModel = models.navigationModel
        self.view = view
    }

}

extension MVPSample1Presenter: MVPSampleRootViewDelegate, MVPSample1InteractiveViewDelegate {

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
