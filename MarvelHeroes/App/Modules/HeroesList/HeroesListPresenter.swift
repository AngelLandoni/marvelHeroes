//
//  HeroesListPresenter.swift
//  MarvelHeroes
//
//  Created by Angel Land on 5/27/17.
//  Copyright © 2017 Landoni Angel. All rights reserved.
//

import UIKit

final class HeroesListPresenter {
    /// A weak reference to the view, it has to be
    /// weak to avoid increase unneccesary the retain count.
    public weak var view: HeroesListViewDelegate!
    /// Queue for the search task.
    private var dispatchSearchQueue: DispatchQueue =
        DispatchQueue.global(qos: .background)
    /// Referente to the search task, it is created
    /// dynamicaly when it is needed.
    var searchTask: DispatchWorkItem!
    
    // MARK: - Private methods
    
    /// This method loads the hero depending the name.
    /// It will be executed X time after the user press
    /// on the last key or the user press on the serach button.
    private func loadHeroes(withName name: String) {
        // Show the loading text.
        DispatchQueue.main.async {
            self.view.updateBackgroundViewTitle(
                withText: LangHelper.load(key: "LoadingTitle", fromFile: "Interface")
            )
        }
        // Load the Heroes!!!!!.
        Networking.loadCharacters(withName: name, success:
        { [weak self] heroes in
            // If the view does not exits it has to return.
            guard let strongSelf = self else { return }
            // Set the heroes.
            strongSelf.view.exposureHeroesTable().set(items: heroes)
            // If there are not Heroes it has to show a 
            // "No heroes" message.
            if heroes.count == 0 {
                DispatchQueue.main.async {
                    strongSelf.view.updateBackgroundViewTitle(
                        withText: LangHelper.load(
                            key: "ThereAreNotHeroes",
                            fromFile: "Interface"
                        )
                    )
                }
            // If there are results it has to hide the text.
            } else {
                DispatchQueue.main.async {
                    strongSelf.view.updateBackgroundViewTitle(withText: "")
                }
            }
        }) { [weak self] in
            // If the view does not exits it has to return.
            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                strongSelf.view.updateBackgroundViewTitle(withText: "")
                strongSelf.view.showNetworkError()
            }
        }
    }
    
    // MARK: - Public methods
    
    /// This method will be called when the user search
    /// something in the search area.
    func onSearchTextChanges(text: String) {
        // Avoid all the string that has less than
        // 3 characters to avoid overload.
        guard text.characters.count >= 3 else {
            view.updateBackgroundViewTitle(
                withText: LangHelper.load(key: "Typing", fromFile: "Interface")
            )
            return
        }
        // If the task already exists it has to cancel it.
        if searchTask != nil {
            searchTask.cancel()
        }
        searchTask = DispatchWorkItem {
            self.loadHeroes(withName: text)
        }
        // Clear all the previous results.
        view.clearHeroesList()
        // Fire a new search.
        dispatchSearchQueue.asyncAfter(
            deadline: .now() + .seconds(3), execute: searchTask)
    }
    
    /// This method will be exectued when the user taps
    /// on the search button.
    /// - parameters: Text: Hero's name.
    func onPressSearchButton(text: String) {
        // Cancel the previous search.
        if searchTask != nil {
            searchTask.cancel()
        }
        // Finally load the hero using the name.
        loadHeroes(withName: text)
    }
    
    /// This method will be executed when the users taps on 
    /// the cell.
    /// - parameters: item: The model.
    /// - parameters: indexPath: The Positon of the item
    func onTapCell(item: HeroBasicModel, indexPath: IndexPath) {
        // If the object does not have ref to the heap
        // it has to return.
        guard let strongView = view else { return }
        strongView.moveToHeroDetail(item: item)
    }
}
