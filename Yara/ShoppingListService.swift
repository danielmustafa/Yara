//
//  ShoppingListService.swift
//  Yara
//
//  Created by Daniel Mustafa on 4/16/21.
//

import Foundation

class ShoppingListService {
    static var shoppingListByAisle = [String:[ExtendedIngredient]]()
    static var shoppingList = [ExtendedIngredient]()
   
    static func getShoppingListAisles() -> [String] {
        return shoppingListByAisle.keys.sorted()
    }
    
    static func addIngredient(ingredient: ExtendedIngredient) {
        
        if var list = shoppingListByAisle[ingredient.aisle!] {
            //list exists for that aisle
            if !ingredientInList(ingredient: ingredient) {
                //ingredient isnt in list
                list.append(copyIngredient(oldIngredient: ingredient))
            } else {
                //ingredient is in list, needs quantity updated
                let index = getIngredientIndex(ingredient: ingredient)
                var updatingIngredient = list[index!]
                updatingIngredient.amount = updatingIngredient.amount + ingredient.amount
                list[index!] = updatingIngredient
            }
            shoppingListByAisle[ingredient.aisle!] = list
        } else {
            //list doesn't exist, create new for that aisle/category
            shoppingListByAisle[ingredient.aisle!] = [ExtendedIngredient]()
            shoppingListByAisle[ingredient.aisle!]?.append(copyIngredient(oldIngredient: ingredient))
        }
    }
    
    static func removeIngredient(ingredient: ExtendedIngredient) {
        if ingredientInList(ingredient: ingredient) {
            if let index = getIngredientIndex(ingredient: ingredient) {
                if var list = shoppingListByAisle[ingredient.aisle!] {
                    list.remove(at: index)
                    shoppingListByAisle[ingredient.aisle!] = list
                }
            }
        }
    }
    
    static func ingredientInList(ingredient: ExtendedIngredient) -> Bool {
        return getIngredientIndex(ingredient: ingredient) != nil
    }
    
    private static func getIngredientIndex(ingredient: ExtendedIngredient) -> Int? {
        if let list = shoppingListByAisle[ingredient.aisle!] {
            return list.firstIndex { (listIngredient) -> Bool in
                ingredient.id == listIngredient.id
            }
        }
        return nil
    }
    
    private static func copyIngredient(oldIngredient: ExtendedIngredient) -> ExtendedIngredient {
        return ExtendedIngredient(id: oldIngredient.id, aisle: oldIngredient.aisle, image: nil, consistency: nil, name: nil, nameClean: oldIngredient.nameClean, original: nil, originalString: nil, originalName: nil, amount: oldIngredient.amount, unit: oldIngredient.unit, meta: [], metaInformation: [], measures: oldIngredient.measures)
        
    }
}
