//
//  SubcategoryTableViewController.swift
//  Yara
//
//  Created by Daniel Mustafa on 4/14/21.
//

import UIKit

class SubcategoryTableViewController: UITableViewController {
    private static var SubcategoryCell = "SubCategoryCell"
    var category : String?
    var subcategories : [String]?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let category = category {
            self.title = category
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
        return subcategories!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SubcategoryTableViewController.SubcategoryCell, for: indexPath)
        let subcategory = subcategories![indexPath.row].capitalized(with: Locale.current)
        cell.textLabel?.text = subcategory
        
        
        let recipesCount = getRecipeIdsBySubcategory(subcategory: subcategory)!.count
        
        if recipesCount > 0 {
            cell.detailTextLabel?.text = String("(\(recipesCount))")
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
            cell.detailTextLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
        } else {
            cell.detailTextLabel?.text = ""
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRecipesDetails" {
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!
            let recipeListView = segue.destination as! RecipeListViewController
            let subcategory = subcategories![indexPath.row]
            let recipes = RecipeService.getRecipesByIds(ids: getRecipeIdsBySubcategory(subcategory: subcategory)!)
            recipeListView.recipes = recipes
        }
    }
    
    private func getRecipeIdsBySubcategory(subcategory: String) -> [Int]? {
        switch category {
        case Category.CUISINE.rawValue:
            if let recipeIds = RecipeService.getRecipeIdsByCuisineType(cuisineType: subcategory) {
                return recipeIds
            }
        case Category.DIET.rawValue:
            if let recipeIds = RecipeService.getRecipeIdsByDiet(dietType: subcategory) {
                return recipeIds
            }
        case Category.DISH_TYPE.rawValue:
            if let recipeIds = RecipeService.getRecipeIdsByDishType(dishType: subcategory.lowercased(with: .current)) {
                return recipeIds
            }
        default: return []
        }
        return []
    }
}
