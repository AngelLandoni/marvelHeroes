//
//  HeroesStorageModule.swift
//  MarvelHeroes
//
//  Created by Angel Land on 5/27/17.
//  Copyright © 2017 Landoni Angel. All rights reserved.
//

struct HeroesStorageModule {
    /// Instantiate the basic components.
    public let view: HeroesStorageView = HeroesStorageView()
    public let presenter: HeroesStoragePresenter = HeroesStoragePresenter()
    
    // Setup the object after instantiate it.
    init() { configureReferences() }
    
    // MARK: - Private methods
    
    /// This method setups the entire component.
    private func configureReferences() {
        view.presenter = presenter
        presenter.view = view
    }
    
    // MARK: - Public methods
    
    /// This method returns the Heroes List view embedded in a
    /// Navigation Controller.
    /// - returns: A MHNavigationController.
    func getViewIntoNavigationController() -> MHNavigationController {
        // Create a new navigation controller and push the view controller
        // into it. The ownership gonna be passed to the navigation controller
        // increasing the retain count, now is responsavility of the
        // navigation controller keep alive the view.
        let navigation: MHNavigationController = MHNavigationController()
        navigation.setViewControllers([view], animated: false)
        return navigation
    }
}
