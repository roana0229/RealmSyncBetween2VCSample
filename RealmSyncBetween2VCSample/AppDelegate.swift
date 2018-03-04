//
//  AppDelegate.swift
//  RealmSyncBetween2VCSample
//
//  Created by Kaoru Tsutsumishita on 2018/03/03.
//  Copyright © 2018年 Kaoru Tsutsumishita. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // created by https://hogehoge.tk/personal/
        let dummyItems = [
            (id: 1, lastName: "キド", firstName: "ブンペイ", gender: "Male", birthday: "1991/09/29"),
            (id: 2, lastName: "イシオカ", firstName: "カエデ", gender: "Female", birthday: "1978/06/29"),
            (id: 3, lastName: "ヨシカワ", firstName: "チエ", gender: "Female", birthday: "1990/05/04"),
            (id: 4, lastName: "フジタ", firstName: "アツヒコ", gender: "Male", birthday: "1959/04/25"),
            (id: 5, lastName: "コクブ", firstName: "タキ", gender: "Female", birthday: "1980/10/01"),
            (id: 6, lastName: "カワイ", firstName: "トモ", gender: "Male", birthday: "1958/11/22"),
            (id: 7, lastName: "タカオカ", firstName: "アキ", gender: "Female", birthday: "1966/02/28"),
            (id: 8, lastName: "キタオカ", firstName: "ウタ", gender: "Female", birthday: "1990/07/07"),
            (id: 9, lastName: "スギモト", firstName: "サワ", gender: "Male", birthday: "1986/03/17"),
            (id: 19, lastName: "ホサカ", firstName: "ユキ", gender: "Female", birthday: "1958/05/22")
        ]


        let realm = try! Realm()
        if realm.objects(ItemEntity.self).count == 0 {
            try! realm.write {
                dummyItems.forEach { dummy in
                    let item = ItemEntity()
                    item.id = dummy.id
                    item.lastName = dummy.lastName
                    item.firstName = dummy.firstName
                    item.gender = dummy.gender
                    item.birthday = dummy.birthday
                    realm.add(item)
                }
            }
        }

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

