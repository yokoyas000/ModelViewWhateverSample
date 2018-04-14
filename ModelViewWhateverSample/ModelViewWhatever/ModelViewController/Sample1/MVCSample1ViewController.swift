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
    private var viewHandler: MVCSample1ViewHandler?
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
        let rootView = MVCSample1RootView()
        self.view = rootView

        let viewHandler = MVCSample1ViewHandler(
            willUpdate: rootView.starButton,
            observe: self.model,
            navigateBy: self.navigator,
            presentBy: ModalPresenter(using: self)
        )

        let controller = MVCSample1Controller(
            reactTo:(
                starButton: rootView.starButton,
                navigateButton: rootView.navigateButton
            ),
            command: self.model,
            update: viewHandler
        )

        self.viewHandler = viewHandler
        self.controller = controller
    }

}
