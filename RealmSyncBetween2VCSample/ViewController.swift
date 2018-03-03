//
//  ViewController.swift
//  RealmSyncBetween2VCSample
//
//  Created by Kaoru Tsutsumishita on 2018/03/03.
//  Copyright © 2018年 Kaoru Tsutsumishita. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private lazy var viewModel = ViewModel(self)

    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.items[indexPath.row]
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "★"
        cell.detailTextLabel?.textColor = item.isStar ? UIColor.orange : UIColor.gray
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }

}

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.onClickCell(id: viewModel.items[indexPath.row].id)
    }

}

private class ViewModel {

    fileprivate struct PresentationModel {
        let id: Int
        let name: String
        let isStar: Bool

        init(id: Int, name: String, isStar: Bool) {
            self.id = id
            self.name = name
            self.isStar = isStar
        }
    }

    private weak var viewController: UIViewController!

    // TODO: DBからレコードを取得
    fileprivate let items = [
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
    ].map { PresentationModel(id: $0.id, name: $0.lastName + " " + $0.firstName, isStar: $0.isStar) }

    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }

    fileprivate func onClickCell(id: Int) {
        if let detailViewController = viewController.storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            detailViewController.itemId = id
            viewController.present(detailViewController, animated: true, completion: nil)
        }
    }

}
