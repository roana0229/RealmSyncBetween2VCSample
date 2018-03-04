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
    func navigate(_ screen: Screen)
}

extension NavigateProtocol where Self: UIViewController {

    func dissmiss() {
        dismiss(animated: true, completion: nil)
    }

    func navigate(_ screen: Screen) {
        present(screen.initialize(), animated: true, completion: nil)
    }

}

extension UIViewController: NavigateProtocol {
}

enum Screen {
    case Home()
    case Detail(itemId: Int)

    func initialize() -> UIViewController {
        switch self {
        case .Home:
            return ViewController.instantiate(storyboard: "Main")
        case let .Detail(itemId):
            let vc = DetailViewController.instantiate(storyboard: "Main")
            vc.itemId = itemId
            return vc
        }
    }
}
