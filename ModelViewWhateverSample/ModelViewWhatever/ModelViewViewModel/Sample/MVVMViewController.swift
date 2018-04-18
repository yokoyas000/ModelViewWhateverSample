//
//  MVVMSampleViewController.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/15.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

class MVVMSampleViewController: UIViewController {

    private let model: DelayStarModelProtocol
    private let navigator: NavigatorProtocol
    private var navigationModel: NavigationRequestModelProtocol?
    private var starViewModel: MVVMSampleStarViewModelInput?
    private var navigationViewModel: MVVMSampleNavigationViewModelInput?

    init(
        model: DelayStarModelProtocol,
        navigator: NavigatorProtocol
    ) {
        self.model = model
        self.navigator = navigator

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    override func loadView() {
        let rootView = MVVMSampleRootView()
        self.view = rootView

        let starViewModel = MVVMSampleStarViewModel(
            observe: self.model
        )
        self.starViewModel = starViewModel

        let navigationModel = NavigationRequestModel(
            observe: self.model
        )
        self.navigationModel = navigationModel

        let navigationViewModel = MVVMSampleNavigationViewModel(
            dependency: (
                starModel: self.model,
                navigator: self.navigator,
                modalPresenter: ModalPresenter(using: self)
            ),
            observe: navigationModel
        )
        self.navigationViewModel = navigationViewModel

        rootView.starButtonOutput = starViewModel
        rootView.navigationButtonOutput = navigationViewModel
        starViewModel.output = rootView
    }
}
