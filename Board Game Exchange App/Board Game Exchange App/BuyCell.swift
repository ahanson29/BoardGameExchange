//
//  BuyCell.swift
//  Board Game Exchange App
//
//  Created by Aaron Hanson on 5/7/20.
//  Copyright © 2020 Aaron Hanson. All rights reserved.
//

import UIKit

class BuyCell: UITableViewCell {

    @IBOutlet weak var thumbnailView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var gameYear: UILabel!
    
    @IBOutlet weak var gameRank: UILabel!
    
    @IBOutlet weak var gameRating: UILabel!
    
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
