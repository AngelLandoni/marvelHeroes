//
//  BackgroundTableView.swift
//  MarvelHeroes
//
//  Created by Angel Land on 5/28/17.
//  Copyright © 2017 Landoni Angel. All rights reserved.
//

import UIKit

class BackgroundTableView: UIView {
    /// The title, it will be in the middle of
    /// the view.
    private var title: UILabel = UILabel()
    
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

    // MARK: - Private methods
    
    /// This method configures all the component.
    private func configureComponent() {
        // Setting title.
        title.textColor = GeneralTheme.dark.getMainTextColor()
        title.text = "Background View"
        title.numberOfLines = 0
        title.font = UIFont.boldSystemFont(ofSize: 30)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .center
        addSubview(title)
    }
    
    /// This method configures all the constraints.
    private func configureConstraints() {
        // Setting title's contraints.
        NSLayoutConstraint.activate([
            title.centerYAnchor.constraint(equalTo: centerYAnchor),
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
            title.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    // MARK: - Public methods
    
    /// This method sets the title of the view.
    func set(title buffer: String) {
        title.text = buffer
    }
}
