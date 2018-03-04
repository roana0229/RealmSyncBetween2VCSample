# List -> Detail 構成のRealmを使ったデータ同期サンプル

## 利用ライブラリ

- [realm/realm-cocoa](https://github.com/realm/realm-cocoa)
- [RxSwiftCommunity/RxRealm](https://github.com/RxSwiftCommunity/RxRealm)
- [ReactiveX/RxSwift](https://github.com/ReactiveX/RxSwift)

## サンプル

1. `carthage bootstrap --platform iOS`
2. `open RealmSyncBetween2VCSample.xcodeproj`

## 該当コード

```.swift
private class ViewModel {

    fileprivate struct PresentationModel {
    ...
    }

    ...
    fileprivate var items: [PresentationModel]

    init(_ viewController: ViewController) {
        ...

        let entities = try! Realm().objects(ItemEntity.self)
        self.items = entities.map { PresentationModel(...) }
        Observable.changeset(from: entities) // RxRealmで変更通知をbindする
            .subscribe(onNext: { [weak self] results, changes in
                ...
                if let changes = changes {
                    ...
                    self?.items = results.map { PresentationModel(...) }
                }
            })
            .disposed(by: disposeBag)
    }

}

```

## 設計の前提

- ViewModelで`Realm.Object`を保持しない
  - 安易にデータの変更をできてしまうため
- Viewへのデータ反映は更新を自動検知する
  - 例外として、`UITableView`などで最適な更新をするためだけにメソッドを呼ぶ
  
## スコープ外

- `Realm.Object` -> 表示用モデルの変換処理の分離（Transformerなど）
- `Realm.Object`へのアクセスの分離（Repositoryなど）
