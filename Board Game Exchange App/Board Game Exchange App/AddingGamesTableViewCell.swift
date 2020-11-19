//
//  AddingGamesTableViewCell.swift
//  Board Game Exchange App
//
//  Created by Aaron Hanson on 5/5/20.
//  Copyright © 2020 Aaron Hanson. All rights reserved.
//

import UIKit
import Firebase

class AddingGamesTableViewCell: UITableViewCell {

    var currUser: String = ""
    var gameID: String = ""
        
    @IBOutlet weak var gameNameLabel: UILabel!
    
    @IBOutlet weak var yearLabel: UILabel!
    
    
    //@IBOutlet weak var addedButton: UILabel!
    
//    @IBAction func addButtonTapped(_ sender: UIButton) {
//        print("Button tapped")
//        addedButton.isHidden = true
//        gameAddedLabel.isHidden = false
//        addedButton.text = "Game Added!"
//
//
//        let newGame = BoardGame(name: gameNameLabel.text!, picture: gameID, rank: rankLabel.text!, publish: yearLabel.text!, rating: ratingLabel.text!, imageView: thumbnailView.image!)
//
//        addBoardGame(newGame)
//
//
//
//    }
    
//    @IBOutlet weak var gameAddedLabel: UILabel!
//
//    var gameDescription: String = ""
//    var gameID: String = ""
//
//    let collection = Firestore.firestore().collection("myBoardGames")
//
//
//    func addBoardGame(_ boardgame: BoardGame) {
//        var ref: DocumentReference?
//        ref = collection.addDocument(data: boardgame.toDict()) {error in
//            if let err = error {
//                print("Error adding document: \(err)")
//            } else {
//                print("Document added with ID: \(ref!.documentID)")
//                boardgame.id = ref!.documentID
//            }
//        }
//
//    }
    
//    func toDict() -> [String: Any] {
//        return ["gameName": gameNameLabel.text!, "year": yearLabel.text!, "bbgRank": rankLabel.text!, "image": thumbnailView.image!, "rating": ratingLabel.text!, "description": gameDescription]
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       // gameAddedLabel.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
