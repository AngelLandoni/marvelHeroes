//
//  MHTabBarController.swift
//  MarvelHeroes
//
//  Created by Angel Land on 5/27/17.
//  Copyright © 2017 Landoni Angel. All rights reserved.
//

import UIKit

final class MHTabBarController: UITabBarController {
    init() {
        super.init(nibName: nil, bundle: nil)
        configureComponent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureComponent()
    }
    
    // MARK: - Private methods
    
    private func configureComponent() {
        tabBar.tintColor = GeneralTheme.dark.getMainTextColor()
        tabBar.barTintColor = GeneralTheme.dark.getMainColor()
        tabBar.backgroundColor = GeneralTheme.dark.getMainColor()
    }
    
    // MARK: - Override properties
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
