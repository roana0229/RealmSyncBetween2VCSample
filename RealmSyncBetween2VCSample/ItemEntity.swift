//
//  Item.swift
//  RealmSyncBetween2VCSample
//
//  Created by Kaoru Tsutsumishita on 2018/03/04.
//  Copyright © 2018年 Kaoru Tsutsumishita. All rights reserved.
//

import UIKit

class ItemEntity {
    
    let id: Int
    let lastName: String
    let firstName: String
    let gender: String
    let birthday: String
    let isStar: Bool

    init(id: Int, lastName: String, firstName: String, gender: String, birthday: String) {
        self.id = id
        self.lastName = lastName
        self.firstName = firstName
        self.gender = gender
        self.birthday = birthday
        self.isStar = false
    }
}
