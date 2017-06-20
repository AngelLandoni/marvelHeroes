//
//  HeroInformationTableViewStructure.swift
//  MarvelHeroes
//
//  Created by Angel Land on 5/28/17.
//  Copyright © 2017 Landoni Angel. All rights reserved.
//

import UIKit

enum HeroInformationTableViewStructure: Int {
    case header
    case description
    
    static let count: Int = 2
    
    func getHeight() -> CGFloat {
        switch self {
        case .header:
            return 200
        case .description:
            return UITableViewAutomaticDimension
        }
    }
    
    func getCell(tableView: UITableView, dataModel: HeroBasicModel) -> UITableViewCell {
        switch self {
        case .header:
            let cell: HeaderHeroInfoCell = tableView.dequeueReusableCell(
                withIdentifier: HeaderHeroInfoCell.getIdentifier()) as! HeaderHeroInfoCell
            cell.set(modelData: dataModel)
            return cell
        case .description:
            let cell: DescriptionCell = tableView.dequeueReusableCell(
                withIdentifier: DescriptionCell.getIdentifier()) as! DescriptionCell
            cell.set(modelData: dataModel)
            return cell
        }
    }
}
