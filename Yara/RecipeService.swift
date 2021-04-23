//
//  RecipeService.swift
//  Yara
//
//  Created by Daniel Mustafa on 4/14/21.
//

import Foundation

public enum Category: String {
    case CUISINE = "Cuisine"
    case DIET = "Diet"
    case DISH_TYPE = "Dish Type"
    
    public static func getRawValues() -> [String] {
        return [self.CUISINE.rawValue, self.DIET.rawValue, self.DISH_TYPE.rawValue]
    }
}

class RecipeService {
    
    private static var recipeMapById = [Int:Recipe]()
    private static var recipeMapByCuisineType = [String:[Int]]()
    private static var recipeMapByDiet = [String:[Int]]()
    private static var recipeMapByDishType = [String:[Int]]()
    
    private static var recipeImagesById = [Int : Data]()
    
    public static func getCategories() -> [String] {
        return Category.getRawValues()
    }
    
    public static func getSubcategoriesByCategory(category: String) -> [String] {
        switch category {
        case Category.CUISINE.rawValue:
            return getCuisineTypes()
        case Category.DIET.rawValue:
            return getDiets()
        case Category.DISH_TYPE.rawValue:
            return getDishTypes()
        default: return []
        }
    }
    
    public static func getCuisineTypes() -> [String] {
        return ["African","American","British","Cajun","Caribbean","Chinese","Eastern European","European","French","German","Greek","Indian","Irish","Italian","Japanese","Jewish","Korean","Latin American","Mediterranean","Mexican","Middle Eastern","Nordic","Southern","Spanish","Thai","Vietnamese"]
            .sorted()
    }
    
    public static func getDiets() -> [String] {
        return getDietsMap().map({element in
            return element["description"]!
        })
    }
    
    public static func getDietsMap() -> [[String: String]] {
        return [
            ["description": "Gluten Free", "value": "gluten free"],
            ["description": "Ketogenic", "value": "ketogenic"],
            ["description": "Vegetarian", "value": "lacto ovo vegetarian"],
            ["description": "Lacto-Vegetarian", "value": "lacto ovo vegetarian"],
            ["description": "Ovo-Vegetarian", "value": "lacto ovo vegetarian"],
            ["description": "Vegan", "value": "vegan"],
            ["description": "Pescetarian", "value": "pescatarian"],
            ["description": "Paleo", "value": "paleo"],
            ["description": "Primal", "value": "primal"],
            ["description": "Whole30", "value": "whole 30"]
        ]
    }
    
    public static func getDishTypes() -> [String] {
        return ["main course","side dish","dessert","appetizer","salad","bread","breakfast","soup","beverage","sauce","marinade","fingerfood","snack","drink"]
            .sorted()
    }
    
    public static func getRecipeIdsByCuisineType(cuisineType: String) -> [Int]? {
        handleGetRecipeIdsBy(getFunc: {return recipeMapByCuisineType[cuisineType]})
    }
    
    public static func getRecipeIdsByDiet(dietType: String) -> [Int]? {
        handleGetRecipeIdsBy(getFunc: {return recipeMapByDiet[dietType]})
    }
    
    public static func getRecipeIdsByDishType(dishType: String) -> [Int]? {
        handleGetRecipeIdsBy(getFunc: {return recipeMapByDishType[dishType]})
    }
    
    private static func handleGetRecipeIdsBy(getFunc: () -> [Int]?) -> [Int]? {
        if let results = getFunc() {
            return results
        } else {
            return []
        }
    }
    
    public static func getRecipeById(id: Int) -> Recipe? {
        return recipeMapById[id]
    }
    
    public static func getRecipesByIds(ids: [Int]) -> [Recipe]? {
        var recipes = [Recipe]()
        ids.forEach({id in
            if let recipe = getRecipeById(id: id) {
                recipes.append(recipe)
            }
        })
        return recipes
    }
    
    public static func getRecipesBySearchCriteria(criteria: String) -> [Recipe] {
        let lowerCriteria = criteria.lowercased()
        let lowercaser = {(v: String) -> String in v.lowercased()}
        return recipeMapById.values.filter { (recipe) -> Bool in
            recipe.title.lowercased().contains(lowerCriteria) ||
            recipe.dishTypes.map(lowercaser).contains(lowerCriteria) ||
            recipe.diets.map(lowercaser).contains(lowerCriteria)
        }
    }   
    
    /// Load Data functions
    public static func loadData() {
        if let path = Bundle.main.path(forResource: "recipes", ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                // Getting data from JSON file using the file URL
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                let decoder = JSONDecoder()
                let jsonData = try! decoder.decode(RecipesContainer.self, from: data)
                let recipes = jsonData.recipes
            
                loadRecipesMapById(recipes: recipes)
                loadRecipesMapByCuisineType(recipes: recipes)
                loadRecipesMapByDiet(recipes: recipes)
                loadRecipesMapByDishType(recipes: recipes)
                loadRecipesMapByDishType(recipes: recipes)
            } catch {
                // Handle error here
            }
        }
    }
    
    private static func loadRecipesMapById(recipes: [Recipe]) {
        recipes.forEach({(recipe: Recipe) in
            recipeMapById[recipe.id] = recipe
        })
    }
    
    private static func loadRecipesMapByCuisineType(recipes: [Recipe]) {
        var recipeByTypes = [Int:[String]]()
        recipes.forEach({(recipe: Recipe) in
            recipeByTypes[recipe.id] = recipe.cuisines
        })
        
        getCuisineTypes().forEach({cuisineType in
            recipeByTypes.filter({element in
                return element.value.contains(cuisineType)
            }).forEach({recipeElement in
                if recipeMapByCuisineType.keys.contains(cuisineType) {
                    if !recipeMapByCuisineType[cuisineType]!.contains(recipeElement.key) {
                        recipeMapByCuisineType[cuisineType]?.append(recipeElement.key)
                    }
                    
                } else {
                    recipeMapByCuisineType[cuisineType] = [recipeElement.key]
                }
            })
        })
    }
    
    private static func loadRecipesMapByDiet(recipes: [Recipe]) {
        var recipesByDiet = [Int:[String]]()
        recipes.forEach({recipe in
            recipesByDiet[recipe.id] = recipe.diets
        })
        
        getDietsMap().forEach({dietEntry in
            recipesByDiet.filter({recipeDiets in
                return recipeDiets.value.contains(dietEntry["value"]!)
            }).forEach({recipe in
                let desc = dietEntry["description"]!
                if recipeMapByDiet.keys.contains(desc) {
                    if !recipeMapByDiet[desc]!.contains(recipe.key) {
                        recipeMapByDiet[desc]?.append(recipe.key)
                    }
                } else {
                    recipeMapByDiet[desc] = [recipe.key]
                }
            })
        })
        
    }
    
    private static func loadRecipesMapByDishType(recipes: [Recipe]) {
        var recipesByDishType = [Int:[String]]()
        recipes.forEach({recipe in
            recipesByDishType[recipe.id] = recipe.dishTypes
        })
        
        getDishTypes().forEach({dishType in
            recipesByDishType.filter({recipeEntry in
                return recipeEntry.value.contains(dishType)
            }).forEach({recipe in
                if recipeMapByDishType.keys.contains(dishType) {
                    if !recipeMapByDishType[dishType]!.contains(recipe.key) {
                        recipeMapByDishType[dishType]?.append(recipe.key)
                    }
                    
                } else {
                    recipeMapByDishType[dishType] = [recipe.key]
                }
            })
        })
        //print(recipeMapByDishType)
    }
    
}
