//
//  UserStore.swift
//  Drink up
//
//  Created by Gupta, Aastha on 10/2/20.
//  Copyright © 2020 Gupta, Aastha. All rights reserved.
//

import Foundation
import Combine

class UserStore: ObservableObject {
    @Published var currentUserInfo: UserInfo? {
        didSet {
            if let encodedData: Data = try? JSONEncoder().encode(currentUserInfo) {
                UserDefaults.standard.set(encodedData, forKey: "UserInfo")
            }
        }
    }
}
