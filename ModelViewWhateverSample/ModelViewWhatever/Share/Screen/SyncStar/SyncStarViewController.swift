//
//  SyncStarViewController.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/13.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

class SyncStarViewController: UIViewController {

    private let model: DelayStarModel
    private var viewHandler: SyncStarViewHandler?

    init(model: DelayStarModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    override func loadView() {
        let rootView = Sub2RootView()
        self.view = rootView

        self.viewHandler = SyncStarViewHandler(
            handle: rootView.starButton,
            interchange: self.model,
            presentBy: ModalPresenter(using: self)
        )
    }

}
