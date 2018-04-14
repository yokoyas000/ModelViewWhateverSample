//
//  MVPSample1Presenter.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

// Presenterの役割:
// - 状態に適した処理の振り分け
// - Modelへ指示を送る
class MVPSample1Presenter {

    private weak var model: DelayStarModel?
    weak var view: MVPSample1ViewHandler?

    init(
        willCommand model: DelayStarModel
    ) {
        self.model = model
    }

    @objc func didTapNavigateButton() {
        guard let model = self.model else {
            return
        }

        // 現在の Model の状態による分岐処理
        switch model.state {
        case .sleeping(current: .star), .processing(next: .star):
            self.view?.navigate(
                to: SyncStarViewController(model: model)
            )
        case .sleeping(current: .unstar), .processing(next: .unstar):
            self.view?.alert()
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

    func didTapAlertAction() {
        guard let model = self.model else {
            return
        }
        self.view?.navigate(to: SyncStarViewController(model: model))
    }

}
