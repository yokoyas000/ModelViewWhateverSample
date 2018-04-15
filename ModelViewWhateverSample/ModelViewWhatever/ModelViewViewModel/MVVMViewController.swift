//
//  MVVMViewController.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/15.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

class MVVMViewController: UIViewController {

    private let model: DelayStarModel
    private let navigator: NavigatorContract

    init(
        model: DelayStarModel,
        navigator: NavigatorContract
        ) {
        self.model = model
        self.navigator = navigator

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    override func loadView() {
        let rootView = RootView()
        self.view = rootView

        // View: 画面の構築/表示, UI要素とアクションの接続
        // Whatever: 内部表現を視覚表現へ変換する, 状態に適したアクションの振り分け, アクションの結果/途中経過を受け取る
    }
}

// - MARK: ViewBinding
class ViewBinding: NSObject {

    private let viewModel: MVVMSampleViewModel

    init(
        binding view: MVPSampleRootView,
        to viewModel: MVVMSampleViewModel
    ) {
        self.viewModel = viewModel

        super.init()

        viewModel.addObserver(
            self,
            forKeyPath: "starText",
            options: [.new, .old],
            context: nil
        )

    }

    deinit {
        self.viewModel.removeObserver(self, forKeyPath: "starText")
    }

}

// - MARK: ViewModel

class MVVMSampleViewModel: NSObject {

    private weak var model: DelayStarModel?
    var starText: String?
    var starTextColor: UIColor?

    init(
        observe model: DelayStarModel,
        initialViewState view: MVPSampleRootView
        ) {
        self.model = model
        self.starText = view.starButton.titleLabel?.text
        self.starTextColor = view.starButton.titleLabel?.textColor
    }
}

extension MVVMSampleViewModel: DelayStarModelReceiver {
    func receive(state: DelayStarModel.State) {
        switch state {
        case .processing(next: .star):
            self.starText = "★"
            self.starTextColor = .darkGray
        case .processing(next: .unstar):
            self.starText = "☆"
            self.starTextColor = .darkGray
        case .sleeping(current: .star):
            self.starText = "★"
            self.starTextColor = .red
        case .sleeping(current: .unstar):
            self.starText = "☆"
            self.starTextColor = .red
        }
    }
}
