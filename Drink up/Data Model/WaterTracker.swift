//
//  WaterTracker.swift
//  Drink up
//
//  Created by Gupta, Aastha on 8/23/20.
//  Copyright © 2020 Gupta, Aastha. All rights reserved.
//

import Foundation
import RealmSwift

class WaterTracker: Object {
    @objc dynamic var date: Date = Utility.getDate()
    @objc dynamic var progress: Int = 0
}
