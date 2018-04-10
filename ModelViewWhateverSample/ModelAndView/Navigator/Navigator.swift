//
//  Navigator.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/11.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

protocol NavigaterContract {
    func navigate(to next: UIViewController)
}

class Navigater: NavigaterContract {

    private weak var viewController: UIViewController?

    init(using viewController: UIViewController) {
        self.viewController = viewController
    }

    func navigate(to next: UIViewController) {
        self.viewController?.navigationController?.pushViewController(next, animated: true)
    }

}
