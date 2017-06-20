//
//  HeroInformationTableViewAdapter.swift
//  MarvelHeroes
//
//  Created by Angel Land on 5/28/17.
//  Copyright © 2017 Landoni Angel. All rights reserved.
//

import UIKit

class HeroInformationTableViewAdapter
: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    /// Hero's information
    private var dataModel: HeroBasicModel!
    
    init() {
        super.init(frame: .zero, style: .grouped)
        configureComponents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureComponents()
    }
    
    // MARK: - Private methods
    
    /// This method configures all the components inside
    /// the class.
    private func configureComponents() {
        // Setting the number of sections, if you want
        // more sections you have to set it by yourself.
        dataSource = self
        delegate = self
        translatesAutoresizingMaskIntoConstraints = false
        separatorStyle = .none
        backgroundColor = GeneralTheme.dark.getBackgroundColor()
        backgroundView = nil
        register(HeaderHeroInfoCell.self,
                 forCellReuseIdentifier: HeaderHeroInfoCell.getIdentifier())
        register(DescriptionCell.self,
                 forCellReuseIdentifier: DescriptionCell.getIdentifier())
    }
    
    // MARK: - Public methods
    
    func set(dataModel: HeroBasicModel) {
        self.dataModel = dataModel
        reloadData()
    }
    
    // MARK: - Table view Delegate and DataSource
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return HeroInformationTableViewStructure(rawValue: indexPath.row)!.getHeight()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return HeroInformationTableViewStructure(rawValue: indexPath.row)!.getHeight()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // If the data does not exits it has to return a empty cell
        // to avoid crash.
        guard let strongDataModel = dataModel else { return UITableViewCell() }
        // If not return the correct cell.
        return HeroInformationTableViewStructure(rawValue: indexPath.row)!.getCell(
            tableView: tableView,
            dataModel: strongDataModel
        )
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HeroInformationTableViewStructure.count
    }
}
