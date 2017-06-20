//
//  HeaderHeroInfoCell.swift
//  MarvelHeroes
//
//  Created by Angel Land on 5/28/17.
//  Copyright © 2017 Landoni Angel. All rights reserved.
//

import UIKit

final class HeaderHeroInfoCell: MHTableViewCell {
    /// The id of the cell.
    static let identifier: String = "HeaderHeroInfo"
    /// The Hero's image.
    private let avatar: UIImageView = UIImageView()
    /// The Hero's name.
    private let name: UILabel = UILabel()
    
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
        
        // Setting the avatar.
        // Cut the content.
        avatar.clipsToBounds = true
        avatar.contentMode = .scaleAspectFill
        avatar.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(avatar)
        
        // Setting name
        name.textColor = UIColor.white
        name.textAlignment = .center
        name.layer.backgroundColor = UIColor.black.cgColor
        name.layer.cornerRadius = 5
        // Allow multilines.
        name.numberOfLines = 0
        name.font = UIFont.boldSystemFont(ofSize: 25)
        name.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(name)
    }
    
    /// This method configures all the constraints.
    private func configureConstraints() {
        // Avatar setup.
        NSLayoutConstraint.activate([
            avatar.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            avatar.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            avatar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            avatar.topAnchor.constraint(equalTo: contentView.topAnchor),
            avatar.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        // Name setup.
        NSLayoutConstraint.activate([
            name.rightAnchor.constraint(equalTo: contentView.rightAnchor,
                                        constant: -20),
            name.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                         constant: -20),
            name.leftAnchor.constraint(equalTo: contentView.leftAnchor,
                                       constant: 20)
            ])
    }
    
    private func updateUI() {
        let heroData: HeroBasicModel = (modelData as! HeroBasicModel)
        if heroData.imageURL != "" {
            avatar.image = HeroAvatarCacheManager.share.get(
                usingId: heroData.imageURL
            )
        } else if heroData.bufferImage != nil{
            avatar.image = UIImage(data: heroData.bufferImage! as Data)
        }
        name.text = heroData.name
    }
    
    // MARK: - Override methods
    
    override func set(modelData: BasicTableViewAdapterItem) {
        super.set(modelData: modelData)
        updateUI()
    }
    
    // MARK: - Override class methods
    
    override class func getIdentifier() -> String {
        return HeaderHeroInfoCell.identifier
    }
}
