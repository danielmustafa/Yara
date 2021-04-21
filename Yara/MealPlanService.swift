//
//  MealPlanService.swift
//  Yara
//
//  Created by Daniel Mustafa on 4/17/21.
//

import Foundation

class MealPlanService {
    static var mealPlan = [Int]()
    
    static func addRecipe(id: Int) {
        if !mealPlan.contains(id) {
            mealPlan.append(id)
        }
        print(mealPlan)
    }
    
    static func removeRecipe(id: Int) {
        if mealPlan.contains(id) {
            let index = mealPlan.firstIndex(of: id)
            mealPlan.remove(at: index!)
        }
    }
    
    static func isRecipeInPlan(id: Int) -> Bool {
        return mealPlan.contains(id)
    }
}
