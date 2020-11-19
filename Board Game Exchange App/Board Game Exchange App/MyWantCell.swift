//
//  MyWantCell.swift
//  Board Game Exchange App
//
//  Created by Aaron Hanson on 5/6/20.
//  Copyright © 2020 Aaron Hanson. All rights reserved.
//

import UIKit

class MyWantCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var yearLabel: UILabel!
    
    var gameID: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
