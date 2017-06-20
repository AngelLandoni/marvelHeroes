//
//  BasicHeroInfoCell.swift
//  MarvelHeroes
//
//  Created by Angel Land on 5/27/17.
//  Copyright © 2017 Landoni Angel. All rights reserved.
//

import UIKit

final class BasicHeroInfoCell: MHTableViewCell {
    /// The id of the cell.
    static let identifier: String = "BasicHeroInfo"
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
        name.textColor = GeneralTheme.dark.getMainTextColor()
        name.textAlignment = .left
        name.layer.backgroundColor = GeneralTheme.dark.getMainColor().cgColor
        name.layer.cornerRadius = 5
        name.numberOfLines = 0
        name.font = UIFont.boldSystemFont(ofSize: 20)
        name.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(name)
    }
    
    /// This method configures all the constraints.
    private func configureConstraints() {
        // Avatar settup.
        NSLayoutConstraint.activate([
            avatar.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            avatar.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            avatar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            avatar.topAnchor.constraint(equalTo: contentView.topAnchor),
            avatar.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        // Name settup.
        NSLayoutConstraint.activate([
            name.rightAnchor.constraint(equalTo: contentView.rightAnchor,
                                        constant: -20),
            name.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                         constant: -20),
            name.leftAnchor.constraint(greaterThanOrEqualTo: contentView.leftAnchor,
                                       constant: 20)
        ])
    }
    
    private func updateUI() {
        // Set the default avater image.
        avatar.image = UIImage(named: "InitialLogo")
        // Set the defalt name.
        name.text = "Loading..."
        // If the hero data does not exist it has to return to
        // avoid a crash.
        guard let rawHeroData = modelData else { return }
        // Avoid a force cast. If it is not possible it has to return 
        // to avoid crash.
        guard let heroData: HeroBasicModel = rawHeroData as? HeroBasicModel else { return }
        // Check if the image exists in memory.
        if let image: UIImage =
            HeroAvatarCacheManager.share.get(usingId: heroData.imageURL) {
            // If the image does exist it has to load it from cache.
            self.avatar.image = image
        } else {
            // It has to load the image and save it into cache.
            Image.loadAsync(fromURL: heroData.imageURL) { (image: UIImage) in
                DispatchQueue.main.async {
                    self.avatar.image = image
                    HeroAvatarCacheManager.share.save(
                        withId: heroData.imageURL, andData: image)
                }
            }
        }
        // Setting the name.
        name.text = heroData.name
    }
    
    // TODO: IMPLEMENTE EN REUSE
    override func prepareForReuse() {
        super.prepareForReuse()
        // CLEAN ALL THE THINGS.
        updateUI()
    }
    
    // MARK: - Override methods
    
    override func set(modelData: BasicTableViewAdapterItem) {
        super.set(modelData: modelData)
        updateUI()
    }
    
    // MARK: - Override class methods
    
    override class func getIdentifier() -> String {
        return BasicHeroInfoCell.identifier
    }
}
