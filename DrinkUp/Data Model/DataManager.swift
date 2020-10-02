//
//  DataManager.swift
//  Drink up
//
//  Created by Gupta, Aastha on 8/23/20.
//  Copyright © 2020 Gupta, Aastha. All rights reserved.
//

import Foundation
import RealmSwift

internal class DataManager {
    static var shared: DataManager = DataManager()

    private let realm = try! Realm()

    private var todayData: WaterTracker

    private var userInfo: UserInfo

    private init() {
        print(Realm.Configuration.defaultConfiguration.fileURL as Any)
        print(Realm.Configuration.defaultConfiguration.encryptionKey as Any)

        self.userInfo = UserInfo(userName: "", userGoal: "6")
        if let userInfoData: Data = UserDefaults.standard.object(forKey: "UserInfo") as? Data, let storedUserInfo: UserInfo = try? JSONDecoder().decode(UserInfo.self, from: userInfoData) {
            self.userInfo = storedUserInfo
        }

        let results: Results<WaterTracker> = realm.objects(WaterTracker.self).filter("date = %@", Utility.getDate())
        if results.count > 0 {
            self.todayData = results[0]
        } else {
            let newData = WaterTracker()
            self.todayData = newData

            do {
                try self.realm.write {
                    self.realm.add(newData)
                }
            } catch {
                print("Error saving to realm, \(error)")
            }

        }
    }

    func getData() -> WaterTracker {
        return self.todayData
    }

    func getUserInfo() -> UserInfo {
        return self.userInfo
    }


    func save() {
        do {
            try realm.write{
                self.todayData.progress = self.todayData.progress + 1
            }
        } catch {
            print("Error saving to realm, \(error)")
        }

    }
}
