//
//  RecipeListCell.swift
//  Yara
//
//  Created by Daniel Mustafa on 4/15/21.
//

import UIKit
import WebKit
class RecipeListCell: UITableViewCell {
    
    public static var DEFAULT_CELL_HEIGHT = 107.0

    @IBOutlet private weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var imageWebView: WKWebView!
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var likesThumbsUpImage: UIImageView!
    @IBOutlet weak var isVegetarianIndicator: UIImageView!
    @IBOutlet weak var glutenFreeIndicator: UIImageView!
    @IBOutlet weak var dairyFreeIndicator: UIImageView!
    @IBOutlet weak var readyInMinLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageWebView.scrollView.isScrollEnabled = false
        // Initialization code
    }
    
    var recipe: Recipe! {
        didSet {
            if (recipe != oldValue) {
                if let recipe = recipe {
                    if let imageUrl = recipe.image {
                        let req = URLRequest(url: URL(string: imageUrl)!)
                        imageWebView.load(req)
                        
                    }
                    
                    if recipe.aggregateLikes != nil {
                        likesCountLabel.text = String(recipe.aggregateLikes)
                    } else {
                        likesCountLabel.isHidden = true
                        likesThumbsUpImage.isHidden = true
                    }
                    
                    readyInMinLabel.text = "\(recipe.readyInMinutes)min."
                    
                    setVegetarianIndicatorVisibility()
                    setGlutenFreeIndicatorVisibility()
                    setDairyFreeIndicatorVisibility()
                    
                    recipeTitleLabel.text = recipe.title
                }
            }
        }
    }
    
    private func setVegetarianIndicatorVisibility() {
        if recipe.vegan || recipe.vegetarian {
            isVegetarianIndicator.alpha = 1.0
        } else {
            isVegetarianIndicator.alpha = 0.10
        }
        
    }
    
    private func setGlutenFreeIndicatorVisibility() {
        if recipe.glutenFree {
            glutenFreeIndicator.alpha = 1.0
        } else {
            glutenFreeIndicator.alpha = 0.10
        }
    }
    
    private func setDairyFreeIndicatorVisibility() {
        if recipe.dairyFree {
            dairyFreeIndicator.alpha = 1.0
        } else {
            dairyFreeIndicator.alpha = 0.10
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
