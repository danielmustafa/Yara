//
//  RecipeViewController.swift
//  Yara
//
//  Created by Daniel Mustafa on 4/15/21.
//

import UIKit
import WebKit
class RecipeViewController: UITableViewController {
    private static var STATIC_ROW_COUNT = 7
    //@IBOutlet weak var favoriteButton: UIBarButtonItem!
    var recipe : Recipe!
    @IBOutlet weak var recipeImageView: WKWebView!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    override func viewWillAppear(_ animated: Bool) {
        setFavoriteButtonStar(setFullStar: FavoritesService.isFavorite(id: recipe.id))
        
        let app = UIApplication.shared
        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationWillEnterForeground(notification:)), name: UIApplication.willEnterForegroundNotification, object: app)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let imageUrl = recipe.image {
            if let url = URL(string: imageUrl) {
                let req = URLRequest(url: url)
                recipeImageView.load(req)
            }
            
            // Along with auto layout, these are the keys for enabling variable cell height
            tableView.estimatedRowHeight = 68.0
            tableView.rowHeight = UITableView.automaticDimension
            
        }

        setFavoriteButtonStar(setFullStar: FavoritesService.isFavorite(id: recipe.id))

    }

    @IBAction func onFavoriteButtonTap(_ sender: UIBarButtonItem) {
        
        if FavoritesService.isFavorite(id: recipe.id) {
            //remove from favorites
            FavoritesService.removeFavorite(id: recipe.id)
            setFavoriteButtonStar(setFullStar: false)
        } else {
            FavoritesService.addFavorite(id: recipe.id)
            setFavoriteButtonStar(setFullStar: true)
        }
        
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let instructionCount = recipe.analyzedInstructions.isEmpty ? 0 :
            recipe.analyzedInstructions[0].steps.count
        return 7 + instructionCount + recipe.extendedIngredients.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell!
        if indexPath.row == 0 {
            //title cell
            cell = tableView.dequeueReusableCell(withIdentifier: "RecipeTitleCell", for: indexPath)
            cell.textLabel?.text = recipe.title
            //print("in title, row: \(indexPath.row)")
        } else if indexPath.row == 1 {
            //summary cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryCell", for: indexPath) as! RecipeSummaryCell
            cell.summary = recipe.summary
            //print("in summary, row: \(indexPath.row)")
            return cell
            
        } else if indexPath.row == 2 {
            //serving size
            cell = tableView.dequeueReusableCell(withIdentifier: "ServingSizeCell", for: indexPath)
            //print("in serving size, row: \(indexPath.row)")
            cell.detailTextLabel?.text = String(recipe.servings)
            
        } else if indexPath.row == 3 {
            //health score
//            cell = tableView.dequeueReusableCell(withIdentifier: "HealthScoreCell", for: indexPath)
//            cell.detailTextLabel?.text = String(recipe.healthScore)
            cell = tableView.dequeueReusableCell(withIdentifier: "ReadyInCell", for: indexPath)
            cell.detailTextLabel?.text = "\(recipe.readyInMinutes) minutes"
            //print("in healthscore, row: \(indexPath.row)")
        } else if indexPath.row == 4 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "MealOptionsCell", for: indexPath) as! MealOptionsCell
            cell.recipe = recipe
            cell.addToMealPlanFunc = { (cell, recipe) in
                if !MealPlanService.isRecipeInPlan(id: recipe.id) {
                    MealPlanService.addRecipe(id: recipe.id)
                    
                    let alert = UIAlertController(title: "Added Meal Plan", message: "Added recipe to meal plan.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                        //nothing
                    }))
                    
                    self.present(alert, animated: true, completion: nil)
                }
            }
            
            cell.addToShoppingListFunc = { (cell, recipe) in
                recipe.extendedIngredients.forEach { (ingredient) in
                    ShoppingListService.addIngredient(ingredient: ingredient)
                }
                
                let alert = UIAlertController(title: "Added Ingredients", message: "Added \(recipe.extendedIngredients.count) items to shopping list!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    //nothing
                }))
                self.present(alert, animated: true, completion: nil)
            }
            
            return cell
        } else if indexPath.row == 5 {
            //ingredients label cell
            cell = tableView.dequeueReusableCell(withIdentifier: "IngredientsLabelCell", for: indexPath)
            cell.textLabel?.text = "Ingredients"
            //print("in ingredientsLabel, row: \(indexPath.row)")
        } else if indexPath.row > 5 && indexPath.row <= (5 + recipe.extendedIngredients.count) {
            //between row 6 and ingredientscount+5
            let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientsCell", for: indexPath) as! IngredientsCell
            
            let position = indexPath.row - 6
            
//            "measures": {
//                "us": {
//                    "amount": 2.0,
//                    "unitShort": "servings",
//                    "unitLong": "servings"
//                },
//                "metric": {
//                    "amount": 2.0,
//                    "unitShort": "servings",
//                    "unitLong": "servings"
//                }
//            }
            
            let defaults = UserDefaults.standard
            let useMetricMeasurement = defaults.bool(forKey: "useMetric")
            
            
            
            let ingredient = recipe.extendedIngredients[position]
            
            let amountValue = useMetricMeasurement
                ? ingredient.measures.metric.amount
                : ingredient.measures.us.amount
            
            let amount =  amountValue.truncatingRemainder(dividingBy: 1.0) != 0
                ? String(format: "%.2f", amountValue)
                : String(Int(amountValue))
            
            let unit = useMetricMeasurement
                ? ingredient.measures.metric.unitShort
                : ingredient.measures.us.unitShort
                
            let ingrName = ingredient.nameClean!.lowercased()
            cell.ingredient =  "\(amount) \(unit) \(ingrName)"
            
            

            return cell
//
        } else if indexPath.row == (5 + recipe.extendedIngredients.count + 1) {
            //instruction label cell
            cell = tableView.dequeueReusableCell(withIdentifier: "InstructionsLabelCell", for: indexPath)
            cell.textLabel?.text = "Instructions"
            //print("in instructionaLabel, row: \(indexPath.row)")
        } else {
            // should now only be instruction steps
            //print("in instriuction, row: \(indexPath.row)")
            let cell = tableView.dequeueReusableCell(withIdentifier: "InstructionCell", for: indexPath) as! InstructionCell
            
            let position = (indexPath.row - 7 - recipe.extendedIngredients.count)
            let instructionList = recipe.analyzedInstructions[0]
            let instruction = instructionList.steps[position]
            cell.stepNumber = String(instruction.number)
            cell.instruction = instruction.step
            return cell
        }
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row > 5 && indexPath.row <= (5 + recipe.extendedIngredients.count) {
            return 47.0
        } else if indexPath.row > (5 + recipe.extendedIngredients.count + 1) {
            return 150
        } else if indexPath.row == 1 {
            //summary
            return 150
        }
        return 47.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row > (5 + recipe.extendedIngredients.count + 1) {
            let cell = tableView.cellForRow(at: indexPath) as! InstructionCell
            
            if cell.instructionLabel.alpha == 1.0 {
                cell.instructionLabel.alpha = 0.25
                cell.stepLabel.alpha = 0.25
            } else {
                cell.instructionLabel.alpha = 1.0
                cell.stepLabel.alpha = 1.0
            }
        }
    }
    
    private func setFavoriteButtonStar(setFullStar: Bool) {
        if setFullStar {
            favoriteButton.image = UIImage(systemName: "star.fill")
        } else {
            favoriteButton.image = UIImage(systemName:  "star")
        }
    }
    
    @objc func applicationWillEnterForeground(notification:NSNotification) {
        let defaults = UserDefaults.standard
        defaults.synchronize()
        tableView.reloadData()
    }
    
}
