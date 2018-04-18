//
//  MVPSample2ViewController.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

class MVPSample2ViewController: UIViewController {

    private let model: DelayStarModelProtocol
    private let navigator: NavigatorProtocol
    private var navigationModel: NavigationRequestModelProtocol?
    private var presenter: MVPSample2PresenterProtocol?

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

        let interactiveView = MVPSample2InteractiveView(
            handle:(
                starButton: rootView.starButton,
                navigationButton: rootView.navigationButton
            ),
            navigateBy: navigator,
            presentBy: ModalPresenter(using: self)
        )
        let navigationModel = NavigationRequestModel(
            observe: self.model
        )
        let presenter = MVPSample2Presenter(
            interchange: (
                starModel: self.model,
                navigationModel: navigationModel
            ),
            willUpdate: interactiveView
        )

        self.navigationModel = navigationModel
        rootView.delegate = presenter
        interactiveView.delegate = presenter
        self.presenter = presenter
    }

}
