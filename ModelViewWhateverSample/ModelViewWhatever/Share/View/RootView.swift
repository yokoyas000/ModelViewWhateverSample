//
//  RootView.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

@IBDesignable
class RootView: UIView {

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
        guard let view = Bundle(for: self.classForCoder)
            .loadNibNamed("RootView", owner: self, options: nil)?
            .first as? UIView else {
                return
        }

        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
    }

}
