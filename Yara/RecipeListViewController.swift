//
//  RecipeListViewController.swift
//  Yara
//
//  Created by Daniel Mustafa on 4/15/21.
//

import UIKit

class RecipeListViewController: UITableViewController {
    
    var recipes: [Recipe]?

    override func viewDidLoad() {
        super.viewDidLoad()

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
        return recipes!.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(UINib(nibName: "RecipeCellTemplate", bundle: nil), forCellReuseIdentifier: "RecipeCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as! RecipeListCell
        let recipe = recipes![indexPath.row]
        cell.recipe = recipe
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(RecipeListCell.DEFAULT_CELL_HEIGHT)
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showRecipe", sender: tableView)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRecipe" {
            let indexPath = self.tableView.indexPathForSelectedRow
            let recipeListView = segue.destination as! RecipeViewController
            let recipe = recipes![indexPath!.row]
            recipeListView.recipe = recipe
        }
    }
}
