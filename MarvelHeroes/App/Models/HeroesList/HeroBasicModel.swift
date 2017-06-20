//
//  HeroeBasicModel.swift
//  MarvelHeroes
//
//  Created by Angel Land on 5/27/17.
//  Copyright © 2017 Landoni Angel. All rights reserved.
//

import UIKit

struct HeroBasicModel {
    var name: String = "Unknown"
    var description: String = "Unknown"
    var imageURL: String = ""
    var bufferImage: NSData? = nil
    
    init(withDictionary data: [String:Any]) {
        name = data["name"] as! String
        description = data["description"] as! String
        imageURL = (data["thumbnail"] as! [String:String])["path"]! + "." +
                    (data["thumbnail"] as! [String:String])["extension"]!
    }
    
    init(withStorageModel data: Hero) {
        name = data.name!
        description = data.descrip!
        bufferImage = data.image
    }
}

// MARK: - BasicTableViewAdapterItem

extension HeroBasicModel: BasicTableViewAdapterItem { }
