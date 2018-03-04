//
//  ViewController.swift
//  RealmSyncBetween2VCSample
//
//  Created by Kaoru Tsutsumishita on 2018/03/03.
//  Copyright © 2018年 Kaoru Tsutsumishita. All rights reserved.
//

import UIKit
import RealmSwift
import RxSwift
import RxRealm

fileprivate protocol ViewProtocol: class {
    func applyChangeset(_ changes: RealmChangeset)
}

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

extension ViewController: ViewProtocol {

    func applyChangeset(_ changes: RealmChangeset) {
        tableView.beginUpdates()
        tableView.deleteRows(at: changes.deleted.map { IndexPath(row: $0, section: 0) }, with: .automatic)
        tableView.insertRows(at: changes.inserted.map { IndexPath(row: $0, section: 0) }, with: .automatic)
        tableView.reloadRows(at: changes.updated.map { IndexPath(row: $0, section: 0) }, with: .automatic)
        tableView.endUpdates()
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

    private weak var navigateProtocol: NavigateProtocol?
    private weak var viewProtocol: ViewProtocol?
    private let disposeBag = DisposeBag()
    fileprivate var items: [PresentationModel]

    init(_ viewController: ViewController) {
        self.navigateProtocol = viewController
        self.viewProtocol = viewController

        let entities = try! Realm().objects(ItemEntity.self)
        self.items = entities.map { PresentationModel(id: $0.id, name: $0.lastName + " " + $0.firstName, isStar: $0.isStar) }
        Observable.changeset(from: entities)
            .subscribe(onNext: { [weak self] results, changes in
                print(results)
                if let changes = changes {
                    print("deleted: \(changes.deleted)")
                    print("inserted: \(changes.inserted)")
                    print("updated: \(changes.updated)")
                    self?.items = results.map { PresentationModel(id: $0.id, name: $0.lastName + " " + $0.firstName, isStar: $0.isStar) }
                    self?.viewProtocol?.applyChangeset(changes)
                }
            })
            .disposed(by: disposeBag)
    }

    fileprivate func onClickCell(id: Int) {
        navigateProtocol?.navigate(.Detail(itemId: id))
    }

}
