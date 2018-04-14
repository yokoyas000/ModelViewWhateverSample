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

    private weak var model: DelayStarModel?
    private let view: MVPSample1ViewHandler

    init(
        willCommand model: DelayStarModel,
        and view: MVPSample1ViewHandler
    ) {
        self.model = model
        self.view = view
    }

}

extension MVPSample1Presenter: MVPSampleRootViewDelegate, MVPSample1ViewHandlerDelegate {

    @objc func didTapnavigationButton() {
        guard let model = self.model else {
            return
        }

        // 現在の Model の状態による分岐処理
        switch model.state {
        case .sleeping(current: .star), .processing(next: .star):
            self.view.navigate(
                to: SyncStarViewController(model: model)
            )
        case .sleeping(current: .unstar), .processing(next: .unstar):
            self.view.alertForNavigation()
        }
    }

    @objc func didTapStarButton() {
        guard let model = self.model else {
            return
        }

        // 現在の Model の状態による分岐処理
        switch model.state {
        case .sleeping(current: .star), .processing(next: .star):
            model.unstar()
        case .sleeping(current: .unstar), .processing(next: .unstar):
            model.star()
        }
    }

    func didTapNavigationAlertAction() {
        guard let model = self.model else {
            return
        }
        self.view.navigate(to: SyncStarViewController(model: model))
    }

}
