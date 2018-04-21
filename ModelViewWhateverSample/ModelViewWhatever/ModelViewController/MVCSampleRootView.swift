//
//  MVCSampleRootView.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/14.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

// Viewの役割:
//  - 画面の構築/表示
class MVCSampleRootView: UIView {

    @IBOutlet var starButton: UIButton!
    @IBOutlet var navigationButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadFromXib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadFromXib()
    }

    private func loadFromXib() {
        guard let view = Bundle.main
            .loadNibNamed("RootView", owner: self, options: nil)?
            .first as? UIView else {
                return
        }
        view.frame = self.frame

        self.addSubview(view)
    }

}
