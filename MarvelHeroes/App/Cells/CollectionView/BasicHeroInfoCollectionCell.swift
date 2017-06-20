//
//  BasicHeroInfoCollectionCell.swift
//  MarvelHeroes
//
//  Created by Angel Land on 5/28/17.
//  Copyright © 2017 Landoni Angel. All rights reserved.
//

import UIKit

final class BasicHeroInfoCollectionCell: MHCollectionViewCell {
    /// This var contains the id of the class.
    static private let identifier: String = "BasicHeroInfoCollection"
    /// The Hero's image.
    private let backgroundImage: UIImageView = UIImageView()
    /// The Hero's name.
    private let name: UILabel = UILabel()
    /// Hero's information.
    private var heroData: HeroBasicModel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureComponent()
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureComponent()
        configureConstraints()
    }
    
    // MARK: Private methods
    
    private func configureComponent() {
        // Setting background image.
        backgroundImage.clipsToBounds = true
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        addSubview(backgroundImage)
        
        // Setting name.
        name.textColor = UIColor.white
        name.textAlignment = .left
        name.layer.backgroundColor = UIColor.black.cgColor
        name.layer.cornerRadius = 5
        // Allow multilines.
        name.numberOfLines = 0
        name.font = UIFont.boldSystemFont(ofSize: 20)
        name.translatesAutoresizingMaskIntoConstraints = false
        addSubview(name)
    }
    
    private func configureConstraints() {
        // Setting backgroud image 's constraints.
        NSLayoutConstraint.activate([
            backgroundImage.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            backgroundImage.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            backgroundImage.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
        
        // Name setup.
        NSLayoutConstraint.activate([
            name.rightAnchor.constraint(equalTo: contentView.rightAnchor,
                                        constant: -5),
            name.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                         constant: -5),
            name.leftAnchor.constraint(equalTo: contentView.leftAnchor,
                                       constant: 5)
        ])
    }
    
    private func updateUI() {
        // Check if the heroData exits, if not it returns to avoid crash.
        guard let strongHeroData: HeroBasicModel = heroData else { return }
        name.text = strongHeroData.name
        backgroundImage.image = UIImage(data: strongHeroData.bufferImage! as Data)
    }
    
    // MARK: - Public methods
    
    func set(heroData data: HeroBasicModel) {
        heroData = data
        updateUI()
    }
    
    override class func getIdentifier() -> String {
        return BasicHeroInfoCollectionCell.identifier
    }
}
