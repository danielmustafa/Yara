//
//  InstructionCell.swift
//  Yara
//
//  Created by Daniel Mustafa on 4/15/21.
//

import UIKit

class InstructionCell: UITableViewCell {

    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var instructionLabel: UILabel!
    
    var stepNumber: String! {
        didSet {
            if stepNumber != oldValue {
                stepLabel.text = stepNumber
            }
        }
    }

    var instruction: String! {
        didSet {
            if instruction != oldValue {
                instructionLabel.text = instruction
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
