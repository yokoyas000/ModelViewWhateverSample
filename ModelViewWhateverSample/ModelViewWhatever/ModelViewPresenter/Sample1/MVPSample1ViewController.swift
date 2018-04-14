//
//  MVPSample1ViewController.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

class MVPSample1ViewController: UIViewController {

    private let model: StarModel
    private let navigator: NavigatorContract
    private var viewHandler: MVPSample1ViewHandler?

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

        let presenter = MVPSample1Presenter(
            willCommand: self.model
        )
        let viewHandler = MVPSample1ViewHandler(
            handle:(
                starButton: rootView.starButton,
                navigateButton: rootView.navigateButton
            ),
            willNotify: presenter,
            observe: self.model,
            navigateBy: self.navigator,
            presentBy: ModalPresenter(using: self)
        )

        self.viewHandler = viewHandler
    }
}


