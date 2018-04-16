//
//  MVVMSampleRootView.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/15.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

//protocol MVVMSampleRootViewInput {
//    var starButton: UIButton { get set }
//    var navigationButton: UIButton { get set }
//}

protocol MVVMSampleRootViewStarOutput: class {
    func didTapStarButton()
}
protocol MVVMSampleRootViewNavigationOutput: class {
    func didTapnavigationButton()
}

// Viewの役割:
//  - 画面の構築/表示
//  - ユーザー操作の受付
class MVVMSampleRootView: UIView {

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
    func update(title: String, color: UIColor, isEnable: Bool) {
        self.starButton.setTitle(title, for: .normal)
        self.starButton.setTitleColor(color, for: .normal)
        self.starButton.isEnabled = isEnable
    }
}

