//
//  FavoritesTableViewController.swift
//  Yara
//
//  Created by Daniel Mustafa on 4/16/21.
//

import UIKit

class FavoritesTableViewController: UITableViewController {
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()

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
        return FavoritesService.favoriteRecipes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(UINib(nibName: "RecipeCellTemplate", bundle: nil), forCellReuseIdentifier: "RecipeCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as! RecipeListCell
        cell.recipe = RecipeService.getRecipeById(id: FavoritesService.favoriteRecipes[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let id = FavoritesService.favoriteRecipes[indexPath.row]
        FavoritesService.removeFavorite(id: id)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRecipe" {
            let indexPath = self.tableView.indexPathForSelectedRow
            let recipeListView = segue.destination as! RecipeViewController
            let recipe = RecipeService.getRecipeById(id: FavoritesService.favoriteRecipes[indexPath!.row])
            recipeListView.recipe = recipe
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showRecipe", sender: tableView)
    }

    @IBAction func onEditButtonTapped(_ sender: UIBarButtonItem) {
        if self.tableView.isEditing {
            self.tableView.isEditing = false
            sender.style = UIBarButtonItem.Style.plain
            sender.title = "Edit"
        } else {
            self.tableView.isEditing = true
            sender.style = UIBarButtonItem.Style.done
            sender.title = "Done"
        }

    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(RecipeListCell.DEFAULT_CELL_HEIGHT)
    }
}
