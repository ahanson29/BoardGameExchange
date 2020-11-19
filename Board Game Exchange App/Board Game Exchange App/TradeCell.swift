//
//  TradeCell.swift
//  Board Game Exchange App
//
//  Created by Aaron Hanson on 5/7/20.
//  Copyright © 2020 Aaron Hanson. All rights reserved.
//

import UIKit

class TradeCell: UITableViewCell {

    @IBOutlet weak var thumbnailView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var yearLabel: UILabel!
    
    @IBOutlet weak var rankLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    
    var gameID: String = ""
    var currUser: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
