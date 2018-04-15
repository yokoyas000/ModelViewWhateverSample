//
//  MVCSample1ViewController.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

class MVCSample1ViewController: UIViewController {

    private let model: DelayStarModel
    private let navigator: NavigatorContract
    private var controller: MVCSample1Controller?

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
        let rootView = MVCSampleRootView()
        self.view = rootView

        let navigationModel = NavigationRequestModel(
            initialNavigationRequest: .nothing,
            observe: model
        )

        let viewHandler = MVCSample1ViewHandler(
            willUpdate: rootView.starButton,
            observe: (
                starModel: self.model,
                navigationModel: navigationModel
            ),
            navigateBy: self.navigator,
            presentBy: ModalPresenter(using: self)
        )

        let controller = MVCSample1Controller(
            reactTo:(
                starButton: rootView.starButton,
                navigationButton: rootView.navigationButton
            ),
            command: (
                starModel: self.model,
                navigationModel: navigationModel
            ),
            update: viewHandler
        )

        self.controller = controller
    }

}
