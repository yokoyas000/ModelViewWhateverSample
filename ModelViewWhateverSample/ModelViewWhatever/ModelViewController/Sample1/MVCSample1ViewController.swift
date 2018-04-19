//
//  MVCSample1ViewController.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

class MVCSample1ViewController: UIViewController {

    private let starModel: DelayStarModelProtocol
    private let navigationModel: NavigationRequestModel
    private let navigator: NavigatorProtocol
    private var controller: MVCSample1ControllerProtocol?

    init(
        starModel: DelayStarModelProtocol,
        navigator: NavigatorProtocol
    ) {
        self.starModel = starModel
        self.navigationModel = NavigationRequestModel(observe: starModel)
        self.navigator = navigator

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    override func loadView() {
        let rootView = MVCSampleRootView()
        self.view = rootView

        let passiveView = MVCSample1PassiveView(
            dependency: (
                starModel: self.starModel,
                navigator: self.navigator,
                modalPresenter: ModalPresenter(using: self)
            ),
            willUpdate: rootView.starButton,
            observe: (
                starModel: self.starModel,
                navigationModel: self.navigationModel
            )
        )

        let controller = MVCSample1Controller(
            reactTo:(
                starButton: rootView.starButton,
                navigationButton: rootView.navigationButton
            ),
            command: (
                starModel: self.starModel,
                navigationModel: self.navigationModel
            ),
            update: passiveView
        )

        self.controller = controller
    }

}
