//
//  IngredientsCell.swift
//  Yara
//
//  Created by Daniel Mustafa on 4/15/21.
//

import UIKit

class IngredientsCell: UITableViewCell {

    @IBOutlet weak var ingredientLabel: UILabel!
    
    var ingredient : String! {
        didSet {
            if (ingredient != oldValue) {
                ingredientLabel.text = ingredient
            }
        }
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
