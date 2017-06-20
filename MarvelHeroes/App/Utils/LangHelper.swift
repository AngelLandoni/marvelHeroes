//
//  LangHelper.swift
//  MarvelHeroes
//
//  Created by Angel Land on 5/27/17.
//  Copyright © 2017 Landoni Angel. All rights reserved.
//

import UIKit

final class LangHelper {
    /// This method loads a specific string from a lang
    /// file.
    static func load(key: String, fromFile file: String) -> String {
        return NSLocalizedString(
            key,
            tableName: file,
            bundle: Bundle.main,
            value: "",
            comment: ""
        )
    }
}
