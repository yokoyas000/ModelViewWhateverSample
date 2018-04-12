//
//  MVCSample1ViewController.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

class MVCSample1ViewController: UIViewController {

    private let model: StarModel
    private let navigator: NavigatorContract
    private var viewHandler: MVCSample1ViewHandler?
    private var controller: MVCSample1Controller?

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

        let viewHandler = MVCSample1ViewHandler(
            willUpdate: rootView.starButton,
            observe: self.model
        )

        let controller = MVCSample1Controller(
            reactTo:(
                starButton: rootView.starButton,
                navigateButton: rootView.navigateButton
            ),
            willCommand: self.model,
            navigateBy: self.navigator,
            presentBy: ModalPresenter(using: self)
        )

        self.viewHandler = viewHandler
        self.controller = controller
    }

}
