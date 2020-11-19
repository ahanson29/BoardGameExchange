//
//  AddSellTradeCell.swift
//  Board Game Exchange App
//
//  Created by Aaron Hanson on 5/7/20.
//  Copyright © 2020 Aaron Hanson. All rights reserved.
//

import UIKit
import Firebase

class AddSellTradeCell: UITableViewCell {

    var currUser: String = ""
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var yearLabel: UILabel!
    
    @IBOutlet weak var rankLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    var gameID: String = ""
    var picture: String = ""
    
    let collection = Firestore.firestore().collection("users")
    let publicGames = Firestore.firestore().collection("allSellTrade")

    
    
    @IBOutlet weak var sellGameButton: UIButton!
    @IBOutlet weak var tradeGameButton: UIButton!
    
    @IBAction func sellGameButtonTapped(_ sender: Any) {
        let game = BoardGame(name: nameLabel.text!, picture: picture, rank: rankLabel.text!, publish: yearLabel.text!, rating: ratingLabel.text!, imageView: thumbnailImageView.image!)
        game.gameStatus.sell =  true
        addBoardGame(game)
        
        sellGameButton.setTitle("Added", for: .normal)
        sellGameButton.tintColor = .red
    }
    
    @IBAction func tradeGameButtonTapped(_ sender: Any) {
        let game = BoardGame(name: nameLabel.text!, picture: picture, rank: rankLabel.text!, publish: yearLabel.text!, rating: ratingLabel.text!, imageView: thumbnailImageView.image!)
        game.gameStatus.trade =  true
        addBoardGame(game)
        tradeGameButton.setTitle("Added", for: .normal)
        tradeGameButton.tintColor = .red
    }
    
    
    func addBoardGame(_ boardgame: BoardGame) {
        print(currUser)
        var ref: DocumentReference?
        let add = collection.document(currUser).collection("mySellTrade")
        ref = add.addDocument(data: boardgame.toDict()) {error in
            if let err = error {
                print("Error adding document: \(err)")
            } else {
                print("Document added to mySellTrade with ID: \(ref!.documentID)")
                boardgame.id = ref!.documentID
            }
        }
        
        ref = publicGames.addDocument(data: boardgame.toDict()) {error in
            if let err = error {
                print("Error adding document: \(err)")
            } else {
                print("Document added publically with ID: \(ref!.documentID)")
                boardgame.id = ref!.documentID
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
