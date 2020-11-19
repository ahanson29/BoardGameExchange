//
//  BoardGameCellTableViewCell.swift
//  IOSParseXMLTutorial
//
//  Created by Aaron Hanson on 5/5/20.
//  Copyright © 2020 Aaron Hanson. All rights reserved.
//

import UIKit

class BoardGameCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var thumbnailView: UIImageView!
    
    @IBOutlet weak var gameNameLabel: UILabel!
    
    @IBOutlet weak var publishYearLabel: UILabel!
    
    @IBOutlet weak var bbgRankLabel: UILabel!
    
    @IBOutlet weak var gameRatingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
