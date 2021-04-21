//
//  MealOptionsCell.swift
//  Yara
//
//  Created by Daniel Mustafa on 4/17/21.
//

import UIKit

class MealOptionsCell: UITableViewCell {
    
    var recipe: Recipe!
    var addToShoppingListFunc: ((UITableViewCell, Recipe) -> Void)?
    var addToMealPlanFunc: ((UITableViewCell, Recipe) -> Void)?
    
    @IBAction func addToMealPlanButton(_ sender: UIButton) {
        addToMealPlanFunc?(self, recipe)
//        if !MealPlanService.isRecipeInPlan(id: recipe.id) {
//            MealPlanService.addRecipe(id: recipe.id)
//        }
    }
    
    @IBAction func addToShoppingListButton(_ sender: UIButton) {
        addToShoppingListFunc?(self, recipe)

        
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
