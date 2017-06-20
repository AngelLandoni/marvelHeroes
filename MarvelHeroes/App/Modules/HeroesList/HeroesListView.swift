//
//  HeroesListView.swift
//  MarvelHeroes
//
//  Created by Angel Land on 5/27/17.
//  Copyright © 2017 Landoni Angel. All rights reserved.
//

import UIKit

protocol HeroesListViewDelegate: class {
    func exposureHeroesTable() -> BasicTableViewAdapter<BasicHeroInfoCell, HeroBasicModel>
    func moveToHeroDetail(item: HeroBasicModel)
    func updateBackgroundViewTitle(withText: String)
    func showNetworkError()
    func clearHeroesList()
}

final class HeroesListView: MHViewController {
    /// A strong reference to the presenter, this var
    /// keep alive the presenter in memory.
    public var presenter: HeroesListPresenter!
    /// The master table view, it contain the heroes list.
    fileprivate var heroesTable = BasicTableViewAdapter<BasicHeroInfoCell, HeroBasicModel>()
    /// Search Controller.
    fileprivate var searchController: UISearchController = UISearchController()
    /// Background view ref.
    fileprivate var heroBackgroundView: BackgroundTableView! = nil
    
    override init() {
        super.init()
        configureComponent()
        configureConstraints()
        configureSearchController()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureComponent()
        configureConstraints()
        configureSearchController()
    }
    
    // MARK: - Private methods
    
    /// This method configures all the components
    /// inside the class.
    private func configureComponent() {
        // Setting view.
        view.backgroundColor = GeneralTheme.dark.getBackgroundColor()
        title = LangHelper.load(key: "HeroesNavigationBarTitle",
                                fromFile: "Interface")
        definesPresentationContext = true
        // Setting tab bar icon.
        tabBarItem = UITabBarItem(
            title: LangHelper.load(key: "HeroesTabText", fromFile: "Interface"),
            image: UIImage(named: "SuperHero")!,
            selectedImage: UIImage(named: "SuperHero")!
        )
        
        // Setting the table view.
        heroesTable.onTap = { (item: HeroBasicModel, indexPath: IndexPath) in
            guard let strongPresenter = self.presenter else { return }
            strongPresenter.onTapCell(item: item, indexPath: indexPath)
        }
        heroBackgroundView = BackgroundTableView(frame: heroesTable.bounds)
        heroBackgroundView.set(title: LangHelper.load(
            key: "SearchHeroTitle",
            fromFile: "Interface"
        ))
        heroesTable.backgroundView = heroBackgroundView
        view.addSubview(heroesTable)
    }
    
    /// This method configures all the containts needed.
    private func configureConstraints() {
        // Setting table view's contraints.
        NSLayoutConstraint.activate([
            heroesTable.leftAnchor.constraint(equalTo: view.leftAnchor), // LEFT
            heroesTable.rightAnchor.constraint(equalTo: view.rightAnchor), // RIGHT
            heroesTable.topAnchor.constraint(equalTo: view.topAnchor), // TOP
            heroesTable.bottomAnchor.constraint(equalTo: view.bottomAnchor) // BOTTOM
        ])
    }
    
    /// This method configures the search controller.
    private func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.showsScopeBar = true
        searchController.searchBar.showsCancelButton = false
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.barTintColor = GeneralTheme.dark.getBackgroundColor()
        searchController.searchBar.tintColor = GeneralTheme.dark.getMainTextColor()
        searchController.searchBar.delegate = self
        searchController.delegate = self
        
        heroesTable.tableHeaderView = searchController.searchBar
    }
}

// MARK: - Search Delegate

extension HeroesListView: UISearchBarDelegate, UISearchControllerDelegate {
    /// This method will be called each time that the user 
    /// press a key on the search area.
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.onSearchTextChanges(text: searchText)
    }
}

// MARK: - Heroes List view delegate

extension HeroesListView: HeroesListViewDelegate {
    /// This method exposes the table view.
    /// - returns: A basic table view adapeter.
    func exposureHeroesTable() -> BasicTableViewAdapter<BasicHeroInfoCell, HeroBasicModel> {
        return heroesTable
    }
    
    /// Push the Hero detail view.
    /// - parameters: item: Hero's data.
    func moveToHeroDetail(item: HeroBasicModel) {
        let heroInfoModule: HeroInformationModule = HeroInformationModule()
        heroInfoModule.presenter.set(heroData: item)
        navigationController?.pushViewController(heroInfoModule.view, animated: true)
    }
    
    /// This method sets the title of the background view.
    /// - parameters: withText: The text to show.
    func updateBackgroundViewTitle(withText text: String) {
        heroBackgroundView.set(title: text)
    }
    
    /// This method shows a generic error related with the net.
    func showNetworkError() {
        let alert: UIAlertController = UIAlertController(
            title: LangHelper.load(key: "AlertErrorTitle", fromFile: "Interface"),
            message: LangHelper.load(key: "AlertErrorBody", fromFile: "Interface"),
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(
            title: LangHelper.load(key: "AlertOkButtonTile", fromFile: "Interface"),
            style: .default,
            handler: nil
        ))
        
        present(alert, animated: true, completion: nil)
    }
    
    /// This method clears the talbe view.
    func clearHeroesList() {
        heroesTable.clear()
    }
}
