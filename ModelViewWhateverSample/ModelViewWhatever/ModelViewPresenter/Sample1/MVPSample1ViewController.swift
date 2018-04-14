//
//  MVPSample1ViewController.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

class MVPSample1ViewController: UIViewController {

    private let model: DelayStarModel
    private let navigator: NavigatorContract
    private var presenter: MVPSample1Presenter?

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
        let rootView = MVPSampleRootView()
        self.view = rootView

        let viewHandler = MVPSample1ViewHandler(
            handle:(
                starButton: rootView.starButton,
                navigationButton: rootView.navigationButton
            ),
            observe: self.model,
            navigateBy: self.navigator,
            presentBy: ModalPresenter(using: self)
        )
        let presenter = MVPSample1Presenter(
            willCommand: self.model,
            and: viewHandler
        )

        viewHandler.delegate = presenter
        rootView.delegate = presenter
        self.presenter = presenter
    }
}


