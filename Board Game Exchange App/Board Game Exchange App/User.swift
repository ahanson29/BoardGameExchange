//
//  User.swift
//  Board Game Exchange App
//
//  Created by Aaron Hanson on 5/2/20.
//  Copyright © 2020 Aaron Hanson. All rights reserved.
//

import Foundation

class User {
    
    var name: String
    var age: String
    var region: String
    var profilePic: String
    var id: String
    
    //var allGames: [BoardGame] = []
    
//    var favoriteGames: [BoardGame]?
//    var wantedGames: [BoardGame]?
//    var selltradeGames: [BoardGame]?
    
    init (name: String, age: String, region: String, profile: String, id: String) {
        self.name = name
        self.age = age
        self.region = region
        self.profilePic = profile
        self.id = id
        
    }
    
    init(dict: [String: Any]) {
        self.name = dict["name"] as! String
        self.age = dict["age"] as! String
        self.region = dict["region"] as! String
        self.profilePic = dict["profPic"] as! String
        self.id = dict["id"] as! String
        
    }
    
    func toDict() -> [String: Any] {
        return ["name": name, "age": age, "region": region, "profPic": profilePic, "id": id]
    }
    
    
//    func setFavorites() {
//        for game in allGames {
//            if game.gameStatus.favorite == true {
//                favoriteGames.append(game)
//            }
//        }
//    }
//
//    func setWanted() {
//        for game in allGames {
//            if game.gameStatus.want == true {
//                wantedGames.append(game)
//            }
//        }
//    }
//
//    func setSellTradeList() {
//        for game in allGames {
//            if game.gameStatus.sell == true || game.gameStatus.trade == true{
//                selltradeGames.append(game)
//            }
//        }
//    }
    
    
}
