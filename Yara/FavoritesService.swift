//
//  FavoritesService.swift
//  Yara
//
//  Created by Daniel Mustafa on 4/16/21.
//

import Foundation

class FavoritesService {
    static var favoriteRecipes = [Int]()
    
    static func addFavorite(id: Int) {
        if !favoriteRecipes.contains(id) {
            favoriteRecipes.append(id)
        }
        print(favoriteRecipes)
    }
    
    static func removeFavorite(id: Int) {
        if favoriteRecipes.contains(id) {
            let index = favoriteRecipes.firstIndex(of: id)
            favoriteRecipes.remove(at: index!)
        }
        print(favoriteRecipes)
    }
    
    static func isFavorite(id: Int) -> Bool {
        return favoriteRecipes.contains(id)
    }
}
