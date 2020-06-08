//
//  DetailViewController.swift
//  SwiftTest
//
//  Created by Matías Gil Echavarría on 6/8/20.
//  Copyright © 2020 Matías Gil Echavarría. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var recipe: Recipe?
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var starOneImage: UIImageView!
    @IBOutlet weak var starTwoImage: UIImageView!
    @IBOutlet weak var starThreeImage: UIImageView!
    @IBOutlet weak var starFourImage: UIImageView!
    @IBOutlet weak var starFiveImage: UIImageView!
    @IBOutlet weak var instructionsLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if NetworkManager.isInternetReachable(), let recipe = self.recipe {
            Recipe.recipeDetail(id: recipe.id) { [weak self] (recipe) in
                self?.recipe = recipe
                self?.setupView()
            }
        }
    }
    
    func setupView(){
        self.navigationController?.title = self.recipe?.title
        self.instructionsLabel.text = self.recipe?.instructions
        
        //set start
        if let rating = self.recipe?.rating {
            for i in 1...rating {
                if let imageView = self.view.viewWithTag(i) as? UIImageView {
                    imageView.image = UIImage(imageLiteralResourceName: "fill_star")
                }
            }
        }
        
    }


}
