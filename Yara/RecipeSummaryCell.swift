//
//  RecipeSummaryCell.swift
//  Yara
//
//  Created by Daniel Mustafa on 4/15/21.
//

import UIKit
import WebKit
class RecipeSummaryCell: UITableViewCell {

    @IBOutlet weak var summaryView: WKWebView!
    var summary : String! {
        didSet {
            if summary != oldValue {
                let headerString = "<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>"

                summaryView.loadHTMLString(headerString+summary, baseURL: nil)
                summaryView.allowsLinkPreview = false
                summaryView.allowsBackForwardNavigationGestures = false
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
