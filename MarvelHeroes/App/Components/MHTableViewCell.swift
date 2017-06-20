//
//  MHTableViewCell.swift
//  MarvelHeroes
//
//  Created by Angel Land on 5/27/17.
//  Copyright © 2017 Landoni Angel. All rights reserved.
//

import UIKit

class MHTableViewCell: UITableViewCell {
    /// Heroes's information bridge.
    var modelData: BasicTableViewAdapterItem!
    
    func set(modelData: BasicTableViewAdapterItem) {
        self.modelData = modelData
    }
    
    /// This method returns the identifier
    /// of the class. Override it to set a 
    /// custom identifier.
    /// - returns: A string that represents the identifier.
    class func getIdentifier() -> String {
        return "MHTableViewCell"
    }
}
