//
//  MVCSample2ViewController.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

class MVCSample2ViewController: UIViewController {

    private let model: DelayStarModel
    private let navigator: NavigatorContract
    private var controller: MVCSample2Controller?

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

        let viewHandler = MVCSample2ViewHandler(
            willUpdate: rootView.starButton,
            navigateBy: self.navigator,
            presentBy: ModalPresenter(using: self)
        )

        let controller = MVCSample2Controller(
            reactTo: (
                starButton: rootView.starButton,
                navigateButton: rootView.navigateButton
            ),
            interchange: self.model,
            command: viewHandler
        )

        self.controller = controller
    }
}
