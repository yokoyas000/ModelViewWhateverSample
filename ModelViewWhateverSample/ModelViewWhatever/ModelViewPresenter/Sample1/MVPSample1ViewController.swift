//
//  MVPSample1ViewController.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

class MVPSample1ViewController: UIViewController {

    private let model: DelayStarModelProtocol
    private let navigator: NavigatorProtocol
    private var presenter: MVPSample1PresenterProtocol?

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
        let rootView = MVPSampleRootView()
        self.view = rootView

        let navigationModel = NavigationRequestModel(
            observe: self.model
        )

        let interactiveView = MVPSample1InteractiveView(
            handle:(
                starButton: rootView.starButton,
                navigationButton: rootView.navigationButton
            ),
            observe:  (
                starModel: self.model,
                navigationModel: navigationModel
            ),
            navigateBy: self.navigator,
            presentBy: ModalPresenter(using: self)
        )
        let presenter = MVPSample1Presenter(
            willCommand: (
                starModel: self.model,
                navigationModel: navigationModel
            ),
            and: interactiveView
        )

        interactiveView.delegate = presenter
        rootView.delegate = presenter
        self.presenter = presenter
    }
}


