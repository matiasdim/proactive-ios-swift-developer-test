//
//  RootViewController.swift
//  SwiftTest
//
//  Created by Matías Gil Echavarría on 6/8/20.
//  Copyright © 2020 Matías Gil Echavarría. All rights reserved.
//


/*

 THANKS!
 
 I would have liked to have more time to
 
 1. Complete all the requirements (Search component is missing
 2. Set the UI more accurate (And remove some runtime constraints conflicts (this is bad!)
 3. Refactor code, mainly network manager to have thisworking more general and probably via singleton pattern
 
 
 Matías.
*/

import UIKit
import KRProgressHUD

class RootViewController: UITableViewController, UISearchResultsUpdating {

    let searchController = UISearchController(searchResultsController: nil)
    var recipes: [Recipe] = []
    var searchedRecipes: [Recipe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Recipies"
        self.navigationController?.navigationBar.barTintColor = .orange
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]        
        
        if NetworkManager.isInternetReachable() {
            KRProgressHUD.show(withMessage: "Getting recipes...")
            Recipe.listRecipes { [weak self] (recipes) in
                KRProgressHUD.dismiss()
                self?.recipes = recipes
                self?.tableView.reloadData()
                
                self?.searchController.searchResultsUpdater = self
                self?.searchController.obscuresBackgroundDuringPresentation = false
                self?.searchController.searchBar.placeholder = "Search"
                self?.navigationItem.searchController = self?.searchController
                self?.definesPresentationContext = true
            }
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.recipes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = self.recipes[indexPath.row].title
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell {
            let index = tableView.indexPath(for: cell)!.row
            let vc = segue.destination as! DetailViewController
            vc.recipe = self.recipes[index]
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
      // TODO
    }
    
}
