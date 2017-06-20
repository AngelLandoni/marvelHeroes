//
//  Time.swift
//  MarvelHeroes
//
//  Created by Angel Land on 5/27/17.
//  Copyright © 2017 Landoni Angel. All rights reserved.
//

import UIKit

class Time {
    /// This method returns the current timestamp.
    static func getCurrentTimestamp() -> String {
        return String(Date.timeIntervalSinceReferenceDate)
    }
}
