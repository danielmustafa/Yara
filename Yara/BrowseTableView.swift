//
//  BrowseTableView.swift
//  Yara
//
//  Created by Daniel Mustafa on 4/14/21.
//

import UIKit

class BrowseTableView: UITableViewController {
    private static let categoryCell = "CategoryCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        RecipeService.loadData()
        
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
        return RecipeService.getCategories().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BrowseTableView.categoryCell, for: indexPath)
        
        let category = RecipeService.getCategories()[indexPath.row]
        cell.textLabel?.text = category
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSubcategoryDetails" {
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!
            let subcategoryView = segue.destination as! SubcategoryTableViewController
            let category = RecipeService.getCategories()[indexPath.row]
            let subcategories = RecipeService.getSubcategoriesByCategory(category: category)
            subcategoryView.subcategories = subcategories
            subcategoryView.category = category
            
            
        }
    }
}
