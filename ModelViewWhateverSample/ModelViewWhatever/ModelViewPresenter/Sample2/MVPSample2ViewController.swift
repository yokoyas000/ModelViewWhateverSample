//
//  MVPSample2ViewController.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

class MVPSample2ViewController: UIViewController {

    private let starModel: DelayStarModelProtocol
    private let navigator: NavigatorProtocol
    private var presenter: MVPSample2PresenterProtocol?

    init(
        starModel: DelayStarModelProtocol,
        navigator: NavigatorProtocol
    ) {
        self.starModel = starModel
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
                navigationButton: rootView.navigationButton,
                navigator: self.navigator,
                modalPresenter: ModalPresenter(using: self)
            )
        )
        let navigationModel = NavigationRequestModel(
            observe: self.starModel
        )
        let presenter = MVPSample2Presenter(
            interchange: (
                starModel: self.starModel,
                navigationModel: navigationModel
            ),
            willUpdate: interactiveView
        )

        rootView.delegate = presenter
        interactiveView.delegate = presenter
        self.presenter = presenter
    }

}
