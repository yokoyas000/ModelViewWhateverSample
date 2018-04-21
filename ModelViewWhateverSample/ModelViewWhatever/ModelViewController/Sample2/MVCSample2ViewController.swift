//
//  MVCSample2ViewController.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

class MVCSample2ViewController: UIViewController {

    private let starModel: DelayStarModelProtocol
    private let navigator: NavigatorProtocol
    private var controller: MVCSample2ControllerProtocol?

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
        let rootView = MVCSampleRootView()
        self.view = rootView

        let passiveView = MVCSample2PassiveView(
            handle: (
                starButton: rootView.starButton,
                navigationButton: rootView.navigationButton,
                navigator: self.navigator,
                modalPresenter: ModalPresenter(using: self)
            )
        )

        let navigationModel = NavigationRequestModel(observe: self.starModel)

        let controller = MVCSample2Controller(
            reactTo: (
                starButton: rootView.starButton,
                navigationButton: rootView.navigationButton
            ),
            interchange: (
                starModel: self.starModel,
                navigationModel: navigationModel
            ),
            update: passiveView
        )

        self.controller = controller
    }
}
