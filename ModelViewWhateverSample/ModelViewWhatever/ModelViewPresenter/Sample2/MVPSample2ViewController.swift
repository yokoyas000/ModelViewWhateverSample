//
//  MVPSample2ViewController.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

class MVPSample2ViewController: UIViewController {

    private let model: StarModel
    private let navigator: NavigatorContract
    private var viewHandler: MVPSample2ViewHandler?

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

        let presenter = MVPSample2Presenter(
            interchange: self.model
        )
        let viewHandler = MVPSample2ViewHandler(
            handle:(
                starButton: rootView.starButton,
                navigationButton: rootView.navigationButton
            ),
            interchange: presenter,
            navigateBy: navigator,
            presentBy: ModalPresenter(using: self)
        )

        self.viewHandler = viewHandler
    }

}
