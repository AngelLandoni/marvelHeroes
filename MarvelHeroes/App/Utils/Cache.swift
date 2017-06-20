//
//  Cache.swift
//  MarvelHeroes
//
//  Created by Angel Land on 5/28/17.
//  Copyright © 2017 Landoni Angel. All rights reserved.
//

import UIKit

final class Cache<Identifier: Hashable, Type> {
    private var data: [Identifier:Type] = [:]
    
    // MARK: - Public methods
    
    /// This method saves the image in RAM.
    /// - parameters: withId: An id object.
    /// - returns: andData: An Type object that contain the data.
    func save(withId id: Identifier, andData data: Type) {
        self.data[id] = data
    }
    
    /// This method returns the object if it exists
    /// in cache.
    /// - parameters: usingId: An id
    /// - returns: Type: A "Type"(Optional) object.
    func get(usingId id: Identifier) -> Type? {
        return data[id]
    }
}
