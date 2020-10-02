//
//  Utility.swift
//  Drink up
//
//  Created by Gupta, Aastha on 8/24/20.
//  Copyright © 2020 Gupta, Aastha. All rights reserved.
//

import Foundation

internal class Utility {
    static func getDate() -> Date {
        let today: Date = Date()
        let components = Calendar.current.dateComponents([.year, .month, .day], from: today)
        let date = Calendar.current.date(from: components)
        return date!
    }
}
