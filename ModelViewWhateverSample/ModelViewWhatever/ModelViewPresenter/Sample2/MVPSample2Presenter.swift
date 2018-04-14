//
//  MVPSample2Presenter.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

// Presenterの役割:
//  - 内部表現を視覚表現へ変換する
//  - 状態に適したアクションの振り分け
//  - アクションの結果/途中経過を受け取る
class MVPSample2Presenter {

    private let model: DelayStarModel
    private let view: MVPSample2ViewHandler

    init(
        interchange model: DelayStarModel,
        willUpdate view: MVPSample2ViewHandler
    ) {
        self.model = model
        self.view = view

        self.model.append(receiver: self)
    }

}

extension MVPSample2Presenter: MVPSampleRootViewDelegate, MVPSample2ViewHandlerDelegate {

    @objc func didTapnavigationButton() {
        // 現在の Model の状態による分岐処理
        switch self.model.state {
        case .sleeping(current: .star), .processing(next: .star):
            self.view.navigate(with: model)
        case .sleeping(current: .unstar), .processing(next: .unstar):
            self.view.alertForNavigation()
        }
    }

    @objc func didTapStarButton() {
        // 現在の Model の状態による分岐処理
        switch model.state {
        case .sleeping(current: .star), .processing(next: .star):
            model.unstar()
        case .sleeping(current: .unstar), .processing(next: .unstar):
            model.star()
        }
    }

    func didTapNavigationAlertAction() {
        self.view.navigate(with: self.model)
    }

    private func update(by state: DelayStarModel.State) {
        switch state {
        case .processing(next: .star):
            self.view.updateStarButton(title: "★", color: .darkGray)
        case .processing(next: .unstar):
            self.view.updateStarButton(title: "☆", color: .darkGray)
        case .sleeping(current: .star):
            self.view.updateStarButton(title: "★", color: .red)

            // ★にした時だけアラートを表示する
            self.view.alertFinithStar()
        case .sleeping(current: .unstar):
            self.view.updateStarButton(title: "☆", color: .red)
        }
    }

}

extension MVPSample2Presenter: DelayStarModelReceiver {
    func receive(state: DelayStarModel.State) {
        self.update(by: state)
    }

}
