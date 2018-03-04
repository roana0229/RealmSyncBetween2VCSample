//
//  DetailViewController.swift
//  RealmSyncBetween2VCSample
//
//  Created by Kaoru Tsutsumishita on 2018/03/03.
//  Copyright © 2018年 Kaoru Tsutsumishita. All rights reserved.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController {

    var itemId: Int!

    private lazy var viewModel = ViewModel(self, itemId: itemId)

    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet private weak var starButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        idLabel.text = "\(viewModel.item.name) \(viewModel.item.gender)\n\(viewModel.item.birthday)"
        starButton.isSelected = viewModel.item.isStar
        starButton.setTitleColor(UIColor.gray, for: .normal)
        starButton.setTitleColor(UIColor.orange, for: .selected)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func actionTapBack(_ sender: Any) {
        viewModel.onClickBack()
    }

    @IBAction func actionTapStar(_ sender: Any) {
        starButton.isSelected = !starButton.isSelected
        viewModel.onClickStar()
    }

}

private class ViewModel {

    fileprivate struct PresentationModel {
        let id: Int
        let name: String
        let gender: String
        let birthday: String
        let isStar: Bool

        init(id: Int, name: String, gender: String, birthday: String, isStar: Bool) {
            self.id = id
            self.name = name
            self.gender = gender
            self.birthday = birthday
            self.isStar = isStar
        }
    }

    private weak var viewController: UIViewController!

    fileprivate let entity: ItemEntity
    fileprivate let item: PresentationModel

    init(_ viewController: UIViewController, itemId: Int) {
        self.viewController = viewController
        self.entity = try! Realm().objects(ItemEntity.self).filter { $0.id == itemId }.first!
        self.item = PresentationModel(id: entity.id,
                                       name: entity.lastName + " " + entity.firstName,
                                       gender: entity.gender == "Male" ? "男性" : "女性",
                                       birthday: entity.birthday.replacingOccurrences(of: "/", with: "-"),
                                       isStar: entity.isStar)
    }

    fileprivate func onClickBack() {
        viewController.dismiss(animated: true, completion: nil)
    }

    fileprivate func onClickStar() {
        try! Realm().write {
            entity.isStar = !entity.isStar
        }
    }

}
