//
//  BoardGame.swift
//  Board Game Exchange App
//
//  Created by Aaron Hanson on 5/2/20.
//  Copyright © 2020 Aaron Hanson. All rights reserved.
//

import Foundation
import UIKit

struct status {
    var want: Bool
    var sell: Bool
    var trade: Bool
    var buy: Bool
    var favorite: Bool
}

class BoardGame {
    
    var name: String
    var picture: String
    var bbgRank: String
    var publishYear: String
    var rating: String
    var thumbnailImagePath: UIImage
    
    
    var gameStatus = status(want: false, sell: false, trade: false, buy: false, favorite: false)
    
    var id: String?
    
    init (name: String, picture: String, rank: String, publish: String, rating: String, imageView: UIImage) {
        self.name = name
        self.picture = picture
        self.bbgRank = rank
        self.publishYear = publish
        self.rating = rating
        self.thumbnailImagePath = imageView
    }
    
    init(dict: [String: Any]) {
        self.name = dict["name"] as! String
        self.picture = dict["picture"] as! String
        self.bbgRank = dict["rank"] as! String
        self.publishYear = dict["year"] as! String
        self.rating = dict["rating"] as! String
        self.thumbnailImagePath = UIImage()
        do {
            if dict["buy"] != nil {
                self.gameStatus.buy = dict["buy"] as! Bool
            }
            if dict["trade"] != nil {
                self.gameStatus.trade = dict["trade"] as! Bool
            }
            if dict["sell"] != nil {
                self.gameStatus.sell = dict["sell"] as! Bool
            }
            if dict["want"] != nil {
                self.gameStatus.want = dict["want"] as! Bool
            }
        }
        
    }
    
    func toDict() -> [String: Any] {
        if(gameStatus.buy == false &&
           gameStatus.trade == false &&
           gameStatus.sell == false &&
           gameStatus.want == false) {
            return ["name": name, "picture": picture, "rank": bbgRank, "year":publishYear, "rating": rating]
        } else {
            return ["name": name, "picture": picture, "rank": bbgRank, "year":publishYear, "rating": rating, "buy": gameStatus.buy, "sell":gameStatus.sell, "trade": gameStatus.trade, "want":gameStatus.want]
        }
        
    }

}
