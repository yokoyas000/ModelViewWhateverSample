//
//  MVVMSampleRootView.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/15.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

// Viewの役割:
//  - 画面の構築/表示
//  - ユーザー操作の受付
@objc
protocol MVVMSampleRootViewStarButtonDelegate: class {
    func didTapStarButton()
}
@objc
protocol MVVMSampleRootViewNavigateButtonDelegate: class {
    func didTapnavigationButton()
}

class MVVMSampleRootView: UIView {

    @IBOutlet var starButton: UIButton!
    @IBOutlet var navigationButton: UIButton!
    weak var starButtonDelegate: MVVMSampleRootViewStarButtonDelegate?
    weak var navigateButtonDelegate: MVVMSampleRootViewNavigateButtonDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }

    @IBAction func didTapStarButton(_ sender: UIButton) {
        self.starButtonDelegate?.didTapStarButton()
    }

    @IBAction func didTapNavigationButton(_ sender: UIButton) {
        self.navigateButtonDelegate?.didTapnavigationButton()
    }

    private func setup() {
        self.loadFromXib()
    }

    private func loadFromXib() {
        guard let view = Bundle.main
            .loadNibNamed("MVVMSampleRootView", owner: self, options: nil)?
            .first as? UIView else {
                return
        }

        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
    }
    
}

