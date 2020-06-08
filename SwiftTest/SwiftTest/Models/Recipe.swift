//
//  Recipe.swift
//  SwiftTest
//
//  Created by Matías Gil Echavarría on 6/8/20.
//  Copyright © 2020 Matías Gil Echavarría. All rights reserved.
//

import UIKit

class Recipe: NSObject {
    
    let id: Int
    let title: String
    let rating: Int?
    let image: String?
    let instructions: String?
    
    init(id: Int, title: String, rating: Int?=nil, image: String?=nil, instructions: String?=nil) {
        self.id = id
        self.title = title
        self.rating = rating
        self.image = image
        self.instructions = instructions
    }
    
    static func listRecipes(callback: @escaping ([Recipe]) -> ()) {
        NetworkManager.getRecipes { (response) in
            var recipes: [Recipe] = []
            if let object = response as? [Dictionary<String, AnyObject>] {
                for item in object {
                    if let id = item["id"] as? Int, let title = item["title"] as? String {
                        let recipe = Recipe(id: id, title: title)
                        recipes.append(recipe)
                    }
                }
            } else {
                print("JSON is invalid")
            }
            callback(recipes)
        }
    }
    
    static func recipeDetail(id: Int, callback: @escaping (Recipe) -> ()) {
        NetworkManager.getRecipe(id: id) { (response) in
            if let object = response as? Dictionary<String, AnyObject> {
                if let id = object["id"] as? Int,
                    let title = object["title"] as? String,
                    let rating = object["rating"] as? Int,
                    let image = object["image"] as? String,
                    let instructions = object["instructions"] as? String {
                    let recipe = Recipe(id: id, title: title, rating: rating, image: image, instructions: instructions)
                    callback(recipe)
                }
            } else {
                // TODO handle failure case
                print("JSON is invalid")
            }
        }
    }
    
//    static func getRecipeImage(url: String, callback: @escaping (UIImage) -> ()) {
//        NetworkManager.getRecipeImage(url: url) { (response) in
//            let image = UIImage(data: (response as AnyObject).data!, scale: 1.0)!
//            callback(image)
//        }
//    }

}
