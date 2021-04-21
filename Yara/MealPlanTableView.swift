//
//  MealPlanTableView.swift
//  Yara
//
//  Created by Daniel Mustafa on 4/17/21.
//

import UIKit

class MealPlanTableView: UITableViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return MealPlanService.mealPlan.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(UINib(nibName: "RecipeCellTemplate", bundle: nil), forCellReuseIdentifier: "RecipeCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as! RecipeListCell
        let recipeId = MealPlanService.mealPlan[indexPath.row]
        cell.recipe = RecipeService.getRecipeById(id: recipeId)
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {

        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let recipeId = MealPlanService.mealPlan[indexPath.row]
            MealPlanService.removeRecipe(id: recipeId)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
    }
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(RecipeListCell.DEFAULT_CELL_HEIGHT)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRecipe" {
            let indexPath = self.tableView.indexPathForSelectedRow
            let recipeListView = segue.destination as! RecipeViewController
            let recipe = RecipeService.getRecipeById(id: MealPlanService.mealPlan[indexPath!.row])
            recipeListView.recipe = recipe
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showRecipe", sender: tableView)
    }
}
