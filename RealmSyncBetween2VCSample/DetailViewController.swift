//
//  DetailViewController.swift
//  RealmSyncBetween2VCSample
//
//  Created by Kaoru Tsutsumishita on 2018/03/03.
//  Copyright © 2018年 Kaoru Tsutsumishita. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var itemId: Int!

    private lazy var viewModel = DetailViewModel(self, itemId: itemId)

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

private class DetailViewModel {

    fileprivate struct DetailPresentationModel {
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
    private let itemId: Int

    // TODO: DBからレコードを取得
    var item: DetailPresentationModel {
        get {
            let items = [
                ItemEntity(id: 1, lastName: "キド", firstName: "ブンペイ", gender: "Male", birthday: "1991/09/29"),
                ItemEntity(id: 2, lastName: "イシオカ", firstName: "カエデ", gender: "Female", birthday: "1978/06/29"),
                ItemEntity(id: 3, lastName: "ヨシカワ", firstName: "チエ", gender: "Female", birthday: "1990/05/04"),
                ItemEntity(id: 4, lastName: "フジタ", firstName: "アツヒコ", gender: "Male", birthday: "1959/04/25"),
                ItemEntity(id: 5, lastName: "コクブ", firstName: "タキ", gender: "Female", birthday: "1980/10/01"),
                ItemEntity(id: 6, lastName: "カワイ", firstName: "トモ", gender: "Male", birthday: "1958/11/22"),
                ItemEntity(id: 7, lastName: "タカオカ", firstName: "アキ", gender: "Female", birthday: "1966/02/28"),
                ItemEntity(id: 8, lastName: "キタオカ", firstName: "ウタ", gender: "Female", birthday: "1990/07/07"),
                ItemEntity(id: 9, lastName: "スギモト", firstName: "サワ", gender: "Male", birthday: "1986/03/17"),
                ItemEntity(id: 19, lastName: "ホサカ", firstName: "ユキ", gender: "Female", birthday: "1958/05/22")
            ]
            let item = items.filter { $0.id == itemId }.first!
            return DetailPresentationModel(id: item.id,
                                           name: item.lastName + " " + item.firstName,
                                           gender: item.gender == "Male" ? "男性" : "女性",
                                           birthday: item.birthday.replacingOccurrences(of: "/", with: "-"),
                                           isStar: item.isStar)
        }
    }

    init(_ viewController: UIViewController, itemId: Int) {
        self.viewController = viewController
        self.itemId = itemId
    }

    fileprivate func onClickBack() {
        viewController.dismiss(animated: true, completion: nil)
    }

    fileprivate func onClickStar() {
        // TODO: DBのデータ書き換え
    }

}
