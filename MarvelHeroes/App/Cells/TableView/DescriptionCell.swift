//
//  DescriptionCell.swift
//  MarvelHeroes
//
//  Created by Angel Land on 5/28/17.
//  Copyright © 2017 Landoni Angel. All rights reserved.
//

import UIKit

final class DescriptionCell: MHTableViewCell {
    /// The id of the cell.
    static let identifier: String = "Description"
    /// The Hero's description.
    private let descript: UILabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureComponent()
        configureConstraints()
    }
    
    init() {
        super.init(
            style: .default,
            reuseIdentifier: BasicHeroInfoCell.identifier
        )
        configureComponent()
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureComponent()
        configureConstraints()
    }
    
    // MARK: - Private methods
    
    /// This method configures all the component.
    private func configureComponent() {
        contentView.backgroundColor = UIColor.black
        selectionStyle = .none
    
        // Setting name
        descript.textColor = UIColor.white
        descript.textAlignment = .left
        // Allow multilines.
        descript.numberOfLines = 0
        descript.font = UIFont.boldSystemFont(ofSize: 15)
        descript.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(descript)
    }
    
    /// This method configures all the constraints.
    private func configureConstraints() {
        // Name setup.
        NSLayoutConstraint.activate([
            descript.rightAnchor.constraint(equalTo: contentView.rightAnchor,
                                        constant: -20),
            descript.topAnchor.constraint(equalTo: contentView.topAnchor,
                                      constant: 20),
            descript.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                         constant: -20),
            descript.leftAnchor.constraint(equalTo: contentView.leftAnchor,
                                       constant: 20)
        ])
    }
    
    private func updateUI() {
        let heroData: HeroBasicModel = (modelData as! HeroBasicModel)
        descript.text = heroData.description
    }
    
    // MARK: - Override methods
    
    override func set(modelData: BasicTableViewAdapterItem) {
        super.set(modelData: modelData)
        updateUI()
    }
    
    // MARK: - Override class methods
    
    override class func getIdentifier() -> String {
        return DescriptionCell.identifier
    }
}
