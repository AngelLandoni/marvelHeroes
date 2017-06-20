//
//  MHCollectionViewCell.swift
//  MarvelHeroes
//
//  Created by Angel Land on 5/28/17.
//  Copyright © 2017 Landoni Angel. All rights reserved.
//

import UIKit

class MHCollectionViewCell: UICollectionViewCell {
    /// This method returns the id of the cell.
    /// Override me!.
    /// - returns: The id of the cell.
    class func getIdentifier() -> String {
        return "CollectionView"
    }
}
