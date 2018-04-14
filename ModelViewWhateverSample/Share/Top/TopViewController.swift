//
//  TopViewController.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/12.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

class TopViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func presentModelAndView(_ sender: UIButton) {
        guard let vc = MainViewController.create(
            model: StarModel(initialStar: false),
            navigator: Navigator(using: self)
        ) else {
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func presentMVCSample1(_ sender: UIButton) {
        self.navigationController?.pushViewController(
            MVCSample1ViewController(
                model: DelayStarModel(initialStarMode: .unstar),
                navigator: Navigator(using: self)
            ),
            animated: true
        )
    }

    @IBAction func presentMVCSample2(_ sender: UIButton) {
        self.navigationController?.pushViewController(
            MVCSample2ViewController(
                model: DelayStarModel(initialStar: .unstar),
                navigator: Navigator(using: self)
            ),
            animated: true
        )
    }

    @IBAction func presentMVPSample1(_ sender: UIButton) {
        self.navigationController?.pushViewController(
            MVPSample1ViewController(
                model: DelayStarModel(initialStar: .unstar),
                navigator: Navigator(using: self)
            ),
            animated: true
        )
    }

    @IBAction func presentMVPSample2(_ sender: UIButton) {
        self.navigationController?.pushViewController(
            MVPSample2ViewController(
                model: DelayStarModel(initialStar: .unstar),
                navigator: Navigator(using: self)
            ),
            animated: true
        )
    }
}
