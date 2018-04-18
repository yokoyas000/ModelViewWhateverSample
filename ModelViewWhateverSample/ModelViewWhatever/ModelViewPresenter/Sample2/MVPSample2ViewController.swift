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
    private let navigator: NavigatorContract
    private var navigationModel: NavigationRequestModel?
    private var presenter: MVPSample2Presenter?

    init(
        model: DelayStarModelProtocol,
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

        let viewHandler = MVPSample2ViewHandler(
            handle:(
                starButton: rootView.starButton,
                navigationButton: rootView.navigationButton
            ),
            navigateBy: navigator,
            presentBy: ModalPresenter(using: self)
        )
        let navigationModel = NavigationRequestModel(
            initialNavigationRequest: .nothing,
            observe: self.model
        )
        let presenter = MVPSample2Presenter(
            interchange: (
                starModel: self.model,
                navigationModel: navigationModel
            ),
            willUpdate: viewHandler
        )

        self.navigationModel = navigationModel
        rootView.delegate = presenter
        viewHandler.delegate = presenter
        self.presenter = presenter
    }

}
