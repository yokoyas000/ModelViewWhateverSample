//
//  ModelPresenter.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/13.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

protocol ModalPresenterProtocol {
    func present(to next: UIViewController)
}

class ModalPresenter: ModalPresenterProtocol {

    private weak var viewController: UIViewController?

    init (using viewController: UIViewController) {
        self.viewController = viewController
    }

    func present(to next: UIViewController) {
        self.viewController?.present(next, animated: true)
    }

}
