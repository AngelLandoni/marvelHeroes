//
//  HeroesStorageView.swift
//  MarvelHeroes
//
//  Created by Angel Land on 5/27/17.
//  Copyright © 2017 Landoni Angel. All rights reserved.
//

import UIKit

protocol HeroesStorageViewDelegate: class {
    func exposureHeroesCollection() -> CeramicCollectionViewAdapter
    func moveToHeroDetail(item: HeroBasicModel)
    func updateBackgroundViewTitle(withText: String)
}

final class HeroesStorageView: MHViewController {
    /// A strong reference to the presenter, this var
    /// keep alive the presenter in memory.
    public var presenter: HeroesStoragePresenter!
    /// The master table view, it contain the heroes list.
    fileprivate var heroesCollection: CeramicCollectionViewAdapter =
        CeramicCollectionViewAdapter()
    /// Background view ref.
    fileprivate var heroBackgroundView: BackgroundTableView! = nil
    
    override init() {
        super.init()
        configureComponent()
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureComponent()
        configureConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.onViewAppear()
    }
    
    // MARK: - Private methods
    
    /// This method configures all the components
    /// inside the class.
    private func configureComponent() {
        // Setting view.
        view.backgroundColor = UIColor.white
        title = LangHelper.load(key: "HeroesStoreNavigationBarTitle",
                                fromFile: "Interface")
        // Setting tab bar icon.
        tabBarItem = UITabBarItem(
            title: LangHelper.load(key: "StorageTabText", fromFile: "Interface"),
            image: UIImage(named: "SuperHeroStorage")!,
            selectedImage: UIImage(named: "SuperHeroStorage")!
        )
        // Setting the table view.
        heroesCollection.onTap = { (item: HeroBasicModel, indexPath: IndexPath) in
            self.presenter.onTapCell(item: item, indexPath: indexPath)
        }
        heroBackgroundView = BackgroundTableView(frame: heroesCollection.bounds)
        heroBackgroundView.set(title: "")
        heroesCollection.backgroundView = heroBackgroundView
        view.addSubview(heroesCollection)
    }
    
    /// This method configures all the containts needed.
    private func configureConstraints() {
        // Setting table view's contraints.
        NSLayoutConstraint.activate([
            heroesCollection.leftAnchor.constraint(equalTo: view.leftAnchor), // LEFT
            heroesCollection.rightAnchor.constraint(equalTo: view.rightAnchor), // RIGHT
            heroesCollection.topAnchor.constraint(equalTo: view.topAnchor), // TOP
            heroesCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor) // BOTTOM
        ])
    }
}

// MARK: - Heroes List view delegate

extension HeroesStorageView: HeroesStorageViewDelegate {
    /// This method returns a reference to the heroes table view.
    func exposureHeroesCollection() -> CeramicCollectionViewAdapter {
        return heroesCollection
    }
    
    func moveToHeroDetail(item: HeroBasicModel) {
        let heroInfoModule: HeroInformationModule = HeroInformationModule()
        heroInfoModule.presenter.set(heroData: item)
        heroInfoModule.view.hideAddButton()
        navigationController?.pushViewController(heroInfoModule.view, animated: true)
    }
    
    /// This method sets the title of the background view.
    /// - parameters: withText: The text to show.
    func updateBackgroundViewTitle(withText text: String) {
        heroBackgroundView.set(title: text)
    }
}
