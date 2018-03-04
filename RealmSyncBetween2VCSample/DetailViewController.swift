//
//  DetailViewController.swift
//  RealmSyncBetween2VCSample
//
//  Created by Kaoru Tsutsumishita on 2018/03/03.
//  Copyright © 2018年 Kaoru Tsutsumishita. All rights reserved.
//

import UIKit
import RealmSwift

fileprivate protocol ViewProtocol: class {
    func updateStar(isStar: Bool)
}

class DetailViewController: UIViewController {

    var itemId: Int!

    private lazy var viewModel = ViewModel(self, itemId: itemId)

    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet private weak var starButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        idLabel.text = viewModel.item.profile
        starButton.isSelected = viewModel.item.isStar
        starButton.setTitleColor(UIColor.gray, for: .normal)
        starButton.setTitleColor(UIColor.orange, for: .selected)
    }

    deinit {
        print("deinit: \(String(describing: self))")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func actionTapBack(_ sender: Any) {
        viewModel.onClickBack()
    }

    @IBAction func actionTapStar(_ sender: Any) {
        viewModel.onClickStar()
    }

}

extension DetailViewController: ViewProtocol {

    func updateStar(isStar: Bool) {
        starButton.isSelected = isStar
    }

}

private class ViewModel {

    fileprivate struct PresentationModel {
        let id: Int
        let profile: String
        let isStar: Bool

        init(id: Int, profile: String, isStar: Bool) {
            self.id = id
            self.profile = profile
            self.isStar = isStar
        }
    }

    private weak var navigateProtocol: NavigateProtocol?
    private weak var viewProtocol: ViewProtocol?
    private let itemId: Int
    fileprivate let item: PresentationModel

    init(_ viewController: DetailViewController, itemId: Int) {
        self.navigateProtocol = viewController
        self.viewProtocol = viewController
        self.itemId = itemId

        let entity = try! Realm().objects(ItemEntity.self).filter { $0.id == itemId }.first!
        let name = entity.lastName + " " + entity.firstName
        let gender = entity.gender == "Male" ? "男性" : "女性"
        let birthdayComponents = entity.birthday.components(separatedBy: "/")
        let birthday = "\(birthdayComponents[0])年\(birthdayComponents[1])月\(birthdayComponents[2])日"
        self.item = PresentationModel(id: entity.id, profile: "\(name)\n\(gender)\n\(birthday)", isStar: entity.isStar)
    }

    fileprivate func onClickBack() {
        navigateProtocol?.dissmiss()
    }

    fileprivate func onClickStar() {
        let entity = try! Realm().objects(ItemEntity.self).filter { $0.id == self.itemId }.first!
        try! Realm().write {
            entity.isStar = !entity.isStar
            viewProtocol?.updateStar(isStar: entity.isStar)
        }
    }

}
