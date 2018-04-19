//
//  MVPSample1ViewController.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

class MVPSample1ViewController: UIViewController {

    private let starModel: DelayStarModelProtocol
    private let navigator: NavigatorProtocol
    private var presenter: MVPSample1PresenterProtocol?

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
        let rootView = MVPSampleRootView()
        self.view = rootView

        let navigationModel = NavigationRequestModel(
            observe: self.starModel
        )

        let interactiveView = MVPSample1InteractiveView(
            handle: (
                starButton: rootView.starButton,
                navigationButton: rootView.navigationButton,
                navigator: self.navigator,
                modalPresenter: ModalPresenter(using: self)
            ),
            dependency: self.starModel,
            observe:  (
                starModel: self.starModel,
                navigationModel: navigationModel
            )
        )
        let presenter = MVPSample1Presenter(
            willCommand: (
                starModel: self.starModel,
                navigationModel: navigationModel
            ),
            and: interactiveView
        )

        interactiveView.delegate = presenter
        rootView.delegate = presenter
        self.presenter = presenter
    }
}


