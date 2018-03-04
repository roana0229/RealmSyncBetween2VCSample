//
//  NavigateProtocol.swift
//  RealmSyncBetween2VCSample
//
//  Created by Kaoru Tsutsumishita on 2018/03/05.
//  Copyright © 2018年 Kaoru Tsutsumishita. All rights reserved.
//

import Foundation

import UIKit

protocol NavigateProtocol: class {
    func dissmiss()
    func navigate(_ viewController: UIViewController)
}

extension NavigateProtocol where Self: UIViewController {

    func dissmiss() {
        dismiss(animated: true, completion: nil)
    }

    func navigate(_ viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
    }

}

extension UIViewController: NavigateProtocol {
}
