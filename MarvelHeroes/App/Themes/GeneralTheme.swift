//
//  GeneralTheme.swift
//  MarvelHeroes
//
//  Created by Angel Land on 5/28/17.
//  Copyright © 2017 Landoni Angel. All rights reserved.
//

import UIKit

enum GeneralTheme: Int {
    case dark
    
    func getMainColor() -> UIColor {
        switch self {
        case .dark:
            return UIColor.black
        }
    }
    
    func getMainTextColor() -> UIColor {
        switch self {
        case .dark:
            return UIColor.white
        }
    }
    
    func getBackgroundColor() -> UIColor {
        switch self {
        case .dark:
            return UIColor(red: 0.16, green: 0.16, blue: 0.16, alpha: 1.0)
        }
    }
}
