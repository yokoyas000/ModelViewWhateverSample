//
//  MVVMSampleRootView.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/15.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

protocol MVVMSampleRootViewInput: MVVMSampleStarViewModelOutput {}
protocol MVVMSampleRootViewStarOutput: class {
    func didTapStarButton()
}
protocol MVVMSampleRootViewNavigationOutput: class {
    func didTapnavigationButton()
}

// View:
//  - 画面の構築/表示
//  - ユーザー操作の受付
class MVVMSampleRootView: UIView, MVVMSampleRootViewInput {

    @IBOutlet var starButton: UIButton!
    @IBOutlet var navigationButton: UIButton!
    weak var starButtonOutput: MVVMSampleRootViewStarOutput?
    weak var navigationButtonOutput: MVVMSampleRootViewNavigationOutput?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }

    @IBAction func didTapStarButton(_ sender: UIButton) {
        self.starButtonOutput?.didTapStarButton()
    }

    @IBAction func didTapNavigationButton(_ sender: UIButton) {
        self.navigationButtonOutput?.didTapnavigationButton()
    }

    private func setup() {
        self.loadFromXib()
    }

    private func loadFromXib() {
        // xib が View
        guard let view = Bundle.main
            .loadNibNamed("AddActionRootView", owner: self, options: nil)?
            .first as? UIView else {
                return
        }

        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
    }
    
}

extension MVVMSampleRootView: MVVMSampleStarViewModelOutput {

    var title: String? {
        get {
            return self.starButton.titleLabel?.text
        }
        set {
            self.starButton.setTitle(newValue, for: .normal)
        }
    }

    var color: UIColor? {
        get {
            return self.starButton.titleLabel?.textColor
        }
        set {
            self.starButton.setTitleColor(newValue, for: .normal)
        }
    }

    var isEnable: Bool {
        get {
            return self.starButton.isEnabled
        }
        set {
            self.starButton.isEnabled = newValue
        }
    }

}

