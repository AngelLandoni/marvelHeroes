//
//  CeramicCollectionViewAdapter.swift
//  MarvelHeroes
//
//  Created by Angel Land on 5/28/17.
//  Copyright © 2017 Landoni Angel. All rights reserved.
//

import UIKit

final class CeramicCollectionViewAdapter: UICollectionView {
    /// List of Heroes.
    fileprivate var heroesList: [HeroBasicModel] = []
    /// Tap callback.
    fileprivate var tapCallback: ((HeroBasicModel, IndexPath) -> Void)? = nil
    
    init() {
        super.init(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        configureComponent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        configureComponent()
    }
    
    // MARK: - Private methods
    
    private func configureComponent() {
        backgroundColor = GeneralTheme.dark.getBackgroundColor()
        delegate = self
        dataSource = self
        translatesAutoresizingMaskIntoConstraints = false
        register(
            BasicHeroInfoCollectionCell.self,
            forCellWithReuseIdentifier: BasicHeroInfoCollectionCell.getIdentifier())
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(
            width: UIScreen.main.bounds.width / 2,
            height: UIScreen.main.bounds.width / 2
        )
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionViewLayout = layout
    }
    
    // MARK: - Public methods
    
    /// This method sets the list of heroes
    func set(heroesList list: [HeroBasicModel]) {
        heroesList = list
        reloadData()
    }
    
    // MARK: - Getters and Setters
    
    var onTap: ((HeroBasicModel, IndexPath) -> Void)? {
        get { return tapCallback }
        set { tapCallback = newValue }
    }
}

// MARK: - Collection view Data source and Delegate

extension CeramicCollectionViewAdapter:
UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return heroesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: BasicHeroInfoCollectionCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BasicHeroInfoCollectionCell.getIdentifier(),
            for: indexPath) as! BasicHeroInfoCollectionCell
        cell.set(heroData: heroesList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        tapCallback?(heroesList[indexPath.row], indexPath)
    }
}
