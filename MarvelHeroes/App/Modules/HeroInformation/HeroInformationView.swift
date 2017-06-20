//
//  HeroInformationView.swift
//  MarvelHeroes
//
//  Created by Angel Land on 5/28/17.
//  Copyright © 2017 Landoni Angel. All rights reserved.
//

import UIKit

protocol HeroInformationViewDelegate: class {
    func exposeHeroesTable() -> HeroInformationTableViewAdapter
    func showSaved()
    func showAleradyExist()
    func showError()
    func hideAddButton()
}

final class HeroInformationView: MHViewController {
    /// A strong reference to the presenter, this var
    /// keep alive the presenter in memory.
    public var presenter: HeroInformationPresenter!
   
    fileprivate var heroInformationTable: HeroInformationTableViewAdapter =
        HeroInformationTableViewAdapter()
    
    override init() {
        super.init()
        configureComponent()
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureComponent()
        configureConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.whenViewAppear()
    }
    
    // MARK: - Private methods
    
    /// This method configures all the components
    /// inside the class.
    private func configureComponent() {
        // Setting hero information table.
        view.backgroundColor = UIColor.black
        view.addSubview(heroInformationTable)
        // Add right bar button.
        navigationItem.setRightBarButton(UIBarButtonItem(
            barButtonSystemItem: UIBarButtonSystemItem.add,
            target: self,
            action: #selector(HeroInformationView.onTapAddButton)), animated: true)
    }
    
    /// This method configures all the containts needed.
    private func configureConstraints() {
        // Setting table view's contraints.
        NSLayoutConstraint.activate([
            heroInformationTable.leftAnchor.constraint(equalTo: view.leftAnchor), // LEFT
            heroInformationTable.rightAnchor.constraint(equalTo: view.rightAnchor), // RIGHT
            heroInformationTable.topAnchor.constraint(equalTo: view.topAnchor), // TOP
            heroInformationTable.bottomAnchor.constraint(equalTo: view.bottomAnchor) // BOTTOM
        ])
    }
    
    // MARK: - Actions
    
    func onTapAddButton() { presenter.onTapAddButton() }
}

// MARK: - HeroInformationViewDelegate

extension HeroInformationView: HeroInformationViewDelegate {
    
    /// This method retuns a reference to the table view.
    func exposeHeroesTable() -> HeroInformationTableViewAdapter {
       return heroInformationTable
    }
    
    /// This method shows a saved(Success) alert.
    func showSaved() {
        let alert: UIAlertController = UIAlertController(
            title: LangHelper.load(key: "AlertSaveOkTitle", fromFile: "Interface"),
            message: LangHelper.load(key: "AlertSaveOkBody", fromFile: "Interface"),
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(
            title: LangHelper.load(key: "AlertOkButtonTile", fromFile: "Interface"),
            style: .default,
            handler: nil
        ))
        
        present(alert, animated: true, completion: nil)
    }
    
    /// This methdo shows an alerady exist alert.
    func showAleradyExist() {
        let alert: UIAlertController = UIAlertController(
            title: LangHelper.load(key: "AlertAlreadyExistTitle", fromFile: "Interface"),
            message: LangHelper.load(key: "AlertAlreadyExistBody", fromFile: "Interface"),
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(
            title: LangHelper.load(key: "AlertOkButtonTile", fromFile: "Interface"),
            style: .default,
            handler: nil
        ))
        
        present(alert, animated: true, completion: nil)
    }
    
    /// This methdo shows an error alert.
    func showError() {
        let alert: UIAlertController = UIAlertController(
            title: LangHelper.load(key: "AlertErrorTitle", fromFile: "Interface"),
            message: LangHelper.load(key: "AlertErrorBody", fromFile: "Interface"),
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(
            title: LangHelper.load(key: "AlertOkButtonTile", fromFile: "Interface"),
            style: .default,
            handler: nil
        ))
        
        present(alert, animated: true, completion: nil)
    }
    
    /// This method hides the right bar button (add Button).
    func hideAddButton() {
        navigationItem.setRightBarButton(nil, animated: false)
    }
}
