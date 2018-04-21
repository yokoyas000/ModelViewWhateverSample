//
//  MVVMSampleRootView.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/15.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

// View:
//  - 画面の構築/表示
//  - ユーザー操作の受付
//  - 内部表現を視覚表現へ変換する
protocol MVVMSampleRootViewInput: MVVMSampleStarViewModelOutput {}

class MVVMSampleRootView: UIView, MVVMSampleRootViewInput {

    @IBOutlet var starButton: UIButton!
    @IBOutlet var navigationButton: UIButton!
    private var starViewModel: MVVMSampleStarViewModelInput!
    private var navigationViewModel: MVVMSampleNavigationViewModelInput!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }

    convenience init(
        observe viewModels: (
            starViewModel: MVVMSampleStarViewModelInput,
            navigationViewModel: MVVMSampleNavigationViewModelInput
        )
    ) {
        self.init()

        self.starViewModel = viewModels.starViewModel
        self.navigationViewModel = viewModels.navigationViewModel

        self.starViewModel.output = self
    }

    @IBAction func didTapStarButton(_ sender: UIButton) {
        self.starViewModel.didTapStarButton()
    }

    @IBAction func didTapNavigationButton(_ sender: UIButton) {
        self.navigationViewModel.didTapnavigationButton()
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
        view.frame = self.frame

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

