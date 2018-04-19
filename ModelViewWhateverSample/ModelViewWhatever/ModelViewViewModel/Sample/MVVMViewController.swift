//
//  MVVMSampleViewController.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/15.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

class MVVMSampleViewController: UIViewController {

    private let starModel: DelayStarModelProtocol
    private let navigator: NavigatorProtocol

    init(
        starModel: DelayStarModelProtocol,
        navigator: NavigatorProtocol
    ) {
        self.starModel = starModel
        self.navigator = navigator

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    override func loadView() {
        let starViewModel = MVVMSampleStarViewModel(
            observe: self.starModel
        )

        let navigationModel = NavigationRequestModel(observe: starModel)
        let navigationViewModel = MVVMSampleNavigationViewModel(
            dependency: (
                starModel: self.starModel,
                navigator: self.navigator,
                modalPresenter: ModalPresenter(using: self)
            ),
            observe: navigationModel
        )
        
        let rootView = MVVMSampleRootView(
            observe: (
                starViewModel: starViewModel,
                navigationViewModel: navigationViewModel
            )
        )
        self.view = rootView

        starViewModel.output = rootView
    }
}
