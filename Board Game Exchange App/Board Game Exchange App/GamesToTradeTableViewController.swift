//
//  GamesToTradeTableViewController.swift
//  Board Game Exchange App
//
//  Created by Aaron Hanson on 5/7/20.
//  Copyright © 2020 Aaron Hanson. All rights reserved.
//

import UIKit
import Firebase


class GamesToTradeTableViewController: UITableViewController {

    var currUser: String = ""
     
      var collection = Firestore.firestore().collection("allSellTrade")
      
      var toTrade: [BoardGame] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 100
         
         loadGames()
         
         
    }

    
    func loadGames() {
        collection.getDocuments(){ querySnapshot, error in
            if let err = error {
                print("Error getting documents: \(err)")
            } else {
                self.toTrade = []
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    let game = BoardGame(dict: document.data())
                    game.id = document.documentID
                    if game.gameStatus.trade {
                        self.toTrade.append(game)
                    }
                    
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
        return toTrade.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TradeCell", for: indexPath) as! TradeCell

        // Configure the cell...
        let game = toTrade[indexPath.row]
        
            cell.nameLabel.text = game.name
            cell.yearLabel.text = game.publishYear
            cell.rankLabel.text = game.bbgRank
        
            let parse = game.rating.split(separator: " ", maxSplits: 2, omittingEmptySubsequences: false)
            
            cell.ratingLabel.text = String(parse[1])
        
            cell.gameID = game.id!
            let url = URL(string: game.picture)
            let image = try? Data(contentsOf: url!)
            cell.thumbnailView.image = UIImage(data: image!)

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
        
//        if segue.identifier == "fromMyWantsToSearch" {
//            if let vc = segue.destination as? SearchMyWantsViewController {
//                vc.currUser = currUser
//            }
//        }

        
    }


}
