//
//  MVCSample2ViewController.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

class MVCSample2ViewController: UIViewController {

    private let model: StarModel
    private let navigator: NavigatorContract
    private var controller: MVCSample2Controller?

    init(
        model: StarModel,
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
            navigateBy: self.navigator
        )

        let controller = MVCSample2Controller(
            reactTo: (
                starButton: rootView.starButton,
                transitionButton: rootView.transitionButton
            ),
            interchange: self.model,
            willCommand: viewHandler
        )

        self.controller = controller
    }
}
