//
//  BasicTableViewAdapter.swift
//  MarvelHeroes
//
//  Created by Angel Land on 5/27/17.
//  Copyright © 2017 Landoni Angel. All rights reserved.
//

import UIKit

protocol BasicTableViewAdapterItem {
}

class BasicTableViewAdapter
<T: MHTableViewCell, I: BasicTableViewAdapterItem>
: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    /// List of items to render.
    private var listOfItems: [I] = []
    /// Tap callback.
    private var tapCallback: ((I, IndexPath) -> Void)? = nil
    
    init() {
        super.init(frame: .zero, style: .grouped)
        configureComponents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureComponents()
    }
    
    // MARK: - Private methods
    
    /// This method configures all the components inside
    /// the class.
    private func configureComponents() {
        // Setting the number of sections, if you want
        // more sections you have to set it by yourself.
        dataSource = self
        delegate = self
        translatesAutoresizingMaskIntoConstraints = false
        separatorStyle = .none
        backgroundColor = GeneralTheme.dark.getBackgroundColor()
        register(T.self, forCellReuseIdentifier: T.getIdentifier())
    }
    
    // MARK: - Public methods
    
    /// This method sets the list of items into the
    /// table view.
    /// - parameters: Items: An array of BasicTableViewAdapterItem items.
    func set(items: [I]) {
        // Avoid empty arrays.
        guard items.count > 0 else { return }
        listOfItems = items
        // Finally render all the cells.
        reloadData()
    }
    
    /// This method append to the list an array of 
    /// BasicTableViewAdapterItem items.
    /// - parameters: Items: An array of BasicTableViewAdapterItem items.
    func add(items: [I]) {
        // Avoid empty arrays.
        guard items.count > 0 else { return }
        listOfItems.append(contentsOf: items)
        // Finally render all the cells.
        reloadData()
    }
    
    /// This method deletes all the cells and the list of 
    /// heroes.
    func clear() {
        listOfItems.removeAll()
        reloadData()
    }
    
    // MARK: - Getters and Setters
    
    var onTap: ((I, IndexPath) -> Void)? {
        get { return tapCallback }
        set { tapCallback = newValue }
    }
    
    // MARK: - Table view Delegate and DataSource
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: T = tableView.dequeueReusableCell(withIdentifier: T.getIdentifier()) as! T
        cell.set(modelData: listOfItems[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tapCallback?(listOfItems[indexPath.row], indexPath)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfItems.count
    }
}
