//
//  MHWindow.swift
//  MarvelHeroes
//
//  Created by Angel Land on 5/27/17.
//  Copyright © 2017 Landoni Angel. All rights reserved.
//

import UIKit

final class MHWindow: UIWindow {
    init() {
        super.init(frame: UIScreen.main.bounds)
        configureComponent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureComponent()
    }
    
    // MARK: - Private methods
    
    /// Setup the component.
    /// Add custom setup here.
    private func configureComponent() {
        makeKeyAndVisible()
    }
}
