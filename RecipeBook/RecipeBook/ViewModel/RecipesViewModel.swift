//
//  RecipesViewModel.swift
//  RecipeBook
//
//  Created by Taeyoun Lee on 2022/03/30.
//

import Foundation

class RecipesViewModel: ObservableObject {
    @Published private(set) var recipes: [Recipe] = []
    
    init() {
        recipes = Recipe.all
    }
    
    func addRecipe(recipe: Recipe) {
        recipes.append(recipe)
    }
}
