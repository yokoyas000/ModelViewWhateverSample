//
//  MVCSample2ViewController.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

class MVCSample2ViewController: UIViewController {

    private let model: DelayStarModelProtocol
    private let navigator: NavigatorProtocol
    private var navigationModel: NavigationRequestModelProtocol?
    private var controller: MVCSample2Controller?

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
        let rootView = MVCSampleRootView()
        self.view = rootView

        let viewHandler = MVCSample2ViewHandler(
            willUpdate: rootView.starButton,
            navigateBy: self.navigator,
            presentBy: ModalPresenter(using: self)
        )

        let navigationModel = NavigationRequestModel(
            observe: self.model
        )

        let controller = MVCSample2Controller(
            reactTo: (
                starButton: rootView.starButton,
                navigationButton: rootView.navigationButton
            ),
            interchange: (
                starModel: self.model,
                navigationModel: navigationModel
            ),
            command: viewHandler
        )

        self.navigationModel = navigationModel
        self.controller = controller
    }
}
