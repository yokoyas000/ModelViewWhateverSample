//
//  Sub2ViewController.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/10.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

/// init で初期化できるようにしたver
class Sub2ViewController: UIViewController {

    private let model: StarModel
    private var viewHandler: SubViewHandler?

    init(model: StarModel) {
        self.model = model

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    override func loadView() {
        let rootView = Sub2RootView()
        self.view = rootView

        self.viewHandler = SubViewHandler(
            handle: rootView.starButton,
            interchange: self.model
        )
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}



