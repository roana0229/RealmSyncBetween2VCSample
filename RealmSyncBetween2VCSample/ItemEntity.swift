//
//  Item.swift
//  RealmSyncBetween2VCSample
//
//  Created by Kaoru Tsutsumishita on 2018/03/04.
//  Copyright © 2018年 Kaoru Tsutsumishita. All rights reserved.
//

import UIKit
import RealmSwift

class ItemEntity: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var lastName: String = ""
    @objc dynamic var firstName: String = ""
    @objc dynamic var gender: String = ""
    @objc dynamic var birthday: String = ""
    @objc dynamic var isStar: Bool = false

    override static func primaryKey() -> String? {
        return "id"
    }

}
