//
//  HeroAvatarCache.swift
//  MarvelHeroes
//
//  Created by Angel Land on 5/28/17.
//  Copyright © 2017 Landoni Angel. All rights reserved.
//

import UIKit

final class HeroAvatarCacheManager {
    /// Pointer to the data in the heap.
    static let share: HeroAvatarCacheManager = HeroAvatarCacheManager()
    /// The CACHE!
    private let cache: Cache<String, UIImage> = Cache<String, UIImage>()
    
    /// Avoid more instances of this class.
    private init() {}
    
    // MARK: - Public methods
    
    /// This method saves the image in RAM.
    /// - parameters: withId: An id object.
    /// - returns: andData: An Type object that contain the data.
    func save(withId id: String, andData data: UIImage) {
        cache.save(withId: id, andData: data)
    }
    
    /// This method returns the object if it exists
    /// in cache.
    /// - parameters: usingId: An id
    /// - returns: Type: A "Type"(Optional) object.
    func get(usingId id: String) -> UIImage? {
        return cache.get(usingId: id)
    }
}
