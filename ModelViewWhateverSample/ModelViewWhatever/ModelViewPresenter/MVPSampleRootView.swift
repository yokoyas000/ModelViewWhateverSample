//
//  MVPSampleRootView.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/14.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

// Viewの役割:
//  - 画面の構築/表示
//  - ユーザー操作の受付
@objc
protocol MVPSampleRootViewDelegate: class {
    func didTapStarButton()
    func didTapnavigationButton()
}

class MVPSampleRootView: UIView {

    @IBOutlet var starButton: UIButton!
    @IBOutlet var navigationButton: UIButton!
    weak var delegate: MVPSampleRootViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }

    private func setup() {
        self.loadFromXib()
    }

    private func loadFromXib() {
        guard let view = Bundle.main
            .loadNibNamed("MVPSampleRootView", owner: self, options: nil)?
            .first as? UIView else {
                return
        }

        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
    }

    @IBAction func didTapStarButton(_ sender: UIButton) {
        self.delegate?.didTapStarButton()
    }
    
    @IBAction func didTapNavigationButton(_ sender: UIButton) {
        self.delegate?.didTapnavigationButton()
    }

}
