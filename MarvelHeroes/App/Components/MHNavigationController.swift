//
//  MHNavigationController.swift
//  MarvelHeroes
//
//  Created by Angel Land on 5/27/17.
//  Copyright © 2017 Landoni Angel. All rights reserved.
//

import UIKit

class MHNavigationController: UINavigationController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        configureComponent()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configureComponent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureComponent()
    }
    
    // MARK: - Private methods
    
    private func configureComponent() {
        navigationBar.barTintColor = GeneralTheme.dark.getMainColor()
        navigationBar.tintColor = GeneralTheme.dark.getMainTextColor()
        navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: GeneralTheme.dark.getMainTextColor()
        ]
    }
    
    // MARK: - Override properties
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
