//
//  ViewController.swift
//  RealmSyncBetween2VCSample
//
//  Created by Kaoru Tsutsumishita on 2018/03/03.
//  Copyright © 2018年 Kaoru Tsutsumishita. All rights reserved.
//

import UIKit
import RealmSwift

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

    fileprivate let entities: [ItemEntity]
    fileprivate let items: [PresentationModel]

    init(_ viewController: UIViewController) {
        self.viewController = viewController
        self.entities = try! Realm().objects(ItemEntity.self).map { $0 }
        self.items = entities.map { PresentationModel(id: $0.id, name: $0.lastName + " " + $0.firstName, isStar: $0.isStar) }
    }

    fileprivate func onClickCell(id: Int) {
        if let detailViewController = viewController.storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            detailViewController.itemId = id
            viewController.present(detailViewController, animated: true, completion: nil)
        }
    }

}
