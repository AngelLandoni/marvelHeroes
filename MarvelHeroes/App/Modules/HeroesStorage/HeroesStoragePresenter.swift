//
//  HeroesStoragePresenter.swift
//  MarvelHeroes
//
//  Created by Angel Land on 5/27/17.
//  Copyright © 2017 Landoni Angel. All rights reserved.
//

import UIKit

final class HeroesStoragePresenter {
    /// A weak reference to the view, it has to be
    /// weak to avoid increase unneccesary the retain count.
    public weak var view: HeroesStorageViewDelegate!
    
    // MARK: - Public methods
    
    /// This method will be executed when the view appears.
    /// AKA: viewWillAppear
    func onViewAppear() {
        // Clear the background text.
        view.updateBackgroundViewTitle(withText: "")
        // Load the Heroes from CoreData.
        DispatchQueue.global(qos: .background).async {
            let heroesList: [HeroBasicModel] = StorageManager.share.getAllHeroes()
            DispatchQueue.main.async {
                // If there are not heroes it has to set a no Heroes
                // text.
                guard heroesList.count > 0 else {
                    self.view.updateBackgroundViewTitle(
                        withText: LangHelper.load(
                            key: "YouDoNotHaveHeroes",
                            fromFile: "Interface"
                        )
                    )
                    return
                }
                // Set all the heroes into the table view.
                self.view.exposureHeroesCollection().set(
                    heroesList: heroesList)
            }
        }
    }
    
    /// This method will be executed when the users taps a
    /// cell.
    /// - parameters: item: The model.
    /// - parameters: indexPath: The Positon of the item
    func onTapCell(item: HeroBasicModel, indexPath: IndexPath) {
        // If the object does not have ref to the heap
        // it has to return.
        guard let strongView = view else { return }
        strongView.moveToHeroDetail(item: item)
    }
}
