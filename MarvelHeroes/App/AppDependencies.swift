//
//  AppDependencies.swift
//  MarvelHeroes
//
//  Created by Angel Land on 5/27/17.
//  Copyright © 2017 Landoni Angel. All rights reserved.
//

import UIKit

final class AppDependencies {
    /// Reference to the main tab bar controller.
    private var tabBarController: MHTabBarController!
    
    init() {
        configureDependencies()
    }
    
    // MARK: - Private methods
    
    /// Setup all the basic modules.
    private func configureDependencies() {
        // Alloc the a new tab bar controller in memory
        // and save the reference into the object.
        tabBarController = MHTabBarController()
        
        // Heroes List module.
        let heroesListModule: HeroesListModule = HeroesListModule()
        // Heroes Storage module.
        let heroesStorageModule: HeroesStorageModule = HeroesStorageModule()
        
        // Create and setup the main modules.
        // Setup all the controllers
        tabBarController.setViewControllers([
            heroesListModule.getViewIntoNavigationController(),
            heroesStorageModule.getViewIntoNavigationController()
        ], animated: false)
    }
    
    // MARK: - Public methods
    
    func configure(window: MHWindow) {
        window.rootViewController = tabBarController
    }
}
