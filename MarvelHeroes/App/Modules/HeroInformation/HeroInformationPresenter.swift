//
//  HeroInformationPresenter.swift
//  MarvelHeroes
//
//  Created by Angel Land on 5/28/17.
//  Copyright © 2017 Landoni Angel. All rights reserved.
//

final class HeroInformationPresenter {
    /// A weak reference to the view, it has to be
    /// weak to avoid increase unneccesary the retain count.
    public weak var view: HeroInformationViewDelegate!
    /// Hero's information.
    private var heroData: HeroBasicModel!
    
    // MARK: - Public methods
    
    /// This method is called when the view is showed.
    /// AKA: viewWillAppear
    func whenViewAppear() {
        view.exposeHeroesTable().set(dataModel: heroData)
    }
    
    func set(heroData data: HeroBasicModel) {
        heroData = data
    }
    
    /// This method will be called when the user taps
    /// over the add button.
    /// TO IMPROVE: Now it is saving the hero using Code
    /// Data, if the app has to load all the heroes
    /// it needs load them from CoreData but if them
    /// are already loaded is a lose of time. To solve
    /// it is necesary a Hero Cache Data to store the
    /// new hero(es) in RAM and when the user whants to
    /// see all theim heroes (and they are already in memory)
    /// it just has to add the new hero(es) in RAM to the 
    /// current Hero(es) also in RAM avoiding load again from coreData.
    func onTapAddButton() {
        let result: StorageManagerResults = StorageManager.share.save(
            hero: heroData
        )
        
        switch result {
        case .correct:
            view.showSaved()
        case .alreadyExist:
            view.showAleradyExist()
        case .error:
            view.showError()
        }
    }
}
