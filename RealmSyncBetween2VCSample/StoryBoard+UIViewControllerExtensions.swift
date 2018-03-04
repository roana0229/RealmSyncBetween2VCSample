//
//  StoryBoard+UIViewControllerExtensions.swift
//  RealmSyncBetween2VCSample
//
//  Created by Kaoru Tsutsumishita on 2018/03/04.
//  Copyright © 2018年 Kaoru Tsutsumishita. All rights reserved.
//

import UIKit

protocol UIViewControllerExtensions {
}

extension UIViewControllerExtensions where Self: UIViewController {

    static func instantiate() -> Self {
        return self.instantiate(storyboard: String(describing: self))
    }

    static func instantiate(storyboard: String) -> Self {
        return self.instantiate(storyboard: storyboard, identifier: String(describing: self))
    }

    static func instantiate(storyboard: String, identifier: String) -> Self {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! Self
    }

}

extension UIViewController: UIViewControllerExtensions {
}
