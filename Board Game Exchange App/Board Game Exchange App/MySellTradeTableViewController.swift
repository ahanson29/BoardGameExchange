//
//  MySellTradeTableViewController.swift
//  Board Game Exchange App
//
//  Created by Aaron Hanson on 5/7/20.
//  Copyright © 2020 Aaron Hanson. All rights reserved.
//

import UIKit
import Firebase
class MySellTradeTableViewController: UITableViewController {
    
    var currUser: String = ""
    
    var mySellTradeList: [BoardGame] = []
    
    let collection = Firestore.firestore().collection("users")

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 150
     
        loadGames()
    }

    func loadGames() {
        let documents = collection.document(currUser).collection("mySellTrade")
        documents.getDocuments(){ querySnapshot, error in
            if let err = error {
                print("Error getting documents: \(err)")
            } else {
                self.mySellTradeList = []
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    let game = BoardGame(dict: document.data())
                    game.id = document.documentID
                    self.mySellTradeList.append(game)
                }
            }
            self.tableView.reloadData()
        }
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return mySellTradeList.count
    }

    
    
 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "selltradeCell", for: indexPath) as! SellTradeCell

        // Configure the cell...
        let game = mySellTradeList[indexPath.row]
        
        cell.gameID = game.id!
        cell.nameLabel.text = game.name
        cell.yearLabel.text = game.publishYear
        
        cell.gameRankLabel.text = game.bbgRank
        cell.gameRatingLabel.text = game.rating
        
        //SET THUMBNAIL, OFFERS AND STATUS BUTTONS
        if(game.gameStatus.sell) {
            cell.statusLabel.backgroundColor = .systemBlue
            cell.statusLabel.text = "For Sale"
        } else {
            cell.statusLabel.backgroundColor = .systemYellow
            cell.statusLabel.text = "For Trade"
        }
        let url = URL(string: game.picture)
        let image = try? Data(contentsOf: url!)
        cell.thumbnailImageView.image = UIImage(data: image!)
        
        return cell
    }

    
    override func viewWillAppear(_ animated: Bool) {
           loadGames()
       }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toAddSellTrade" {
            if let vc = segue.destination as? AddToSellTradeTableViewController {
                vc.currUser = self.currUser
            }
        }
    }


}
