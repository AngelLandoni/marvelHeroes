//
//  StorageManager.swift
//  MarvelHeroes
//
//  Created by Angel Land on 5/28/17.
//  Copyright © 2017 Landoni Angel. All rights reserved.
//

import UIKit
import CoreData

enum StorageManagerResults {
    case correct
    case error
    case alreadyExist
}

final class StorageManager {
    /// Ref to the object in the heap.
    static let share: StorageManager = StorageManager()
    /// A reference to the context.
    private var context: NSManagedObjectContext!
    
    // Avoid multiples objects.
    private init() {
        configureComponent()
    }
    
    // MARK: - Private methods
    
    private func configureComponent() {
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    // MARK: - Public methods
    
    func save(hero: HeroBasicModel) -> StorageManagerResults {
        // If the hero already exist it has to return.
        guard get(heroWithName: hero.name).count == 0 else { return .alreadyExist }
        // If not it has to save it.
        let heroStorage: Hero = Hero(context: context)
        heroStorage.name = hero.name
        heroStorage.descrip = hero.description
        heroStorage.image = UIImagePNGRepresentation(
            HeroAvatarCacheManager.share.get(usingId: hero.imageURL)!
        ) as NSData?
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        return .correct
    }
    
    func get(heroWithName name: String) -> [HeroBasicModel] {
        var heroes: [Hero] = []
        do {
            let fetchRequest: NSFetchRequest = Hero.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "name == %@", name)
            heroes = try context.fetch(fetchRequest)
        } catch {
            print("Failed pull data.")
        }
        var heroesBasicData: [HeroBasicModel] = []
        
        for hero in heroes {
            heroesBasicData.append(HeroBasicModel(withStorageModel: hero))
        }
        
        return heroesBasicData
    }
    
    func getAllHeroes() -> [HeroBasicModel] {
        var heroes: [Hero] = []
        do {
            heroes = try context.fetch(Hero.fetchRequest())
        } catch {
            print("Fail pulling data.")
        }
        var heroesBasicData: [HeroBasicModel] = []
        
        for hero in heroes {
            heroesBasicData.append(HeroBasicModel(withStorageModel: hero))
        }
        
        return heroesBasicData
    }
}
