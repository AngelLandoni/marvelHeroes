//
//  HeroInformationModule.swift
//  MarvelHeroes
//
//  Created by Angel Land on 5/28/17.
//  Copyright © 2017 Landoni Angel. All rights reserved.
//

struct HeroInformationModule {
    /// Instantiate the basic components.
    public let view: HeroInformationView = HeroInformationView()
    public let presenter: HeroInformationPresenter = HeroInformationPresenter()
    
    // Setup the object after instantiate it.
    init() { configureReferences() }
    
    // MARK: - Private methods
    
    /// This method setups the entire component.
    private func configureReferences() {
        view.presenter = presenter
        presenter.view = view
    }
}
