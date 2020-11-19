//
//  MyGamesTableViewController.swift
//  Board Game Exchange App
//
//  Created by Aaron Hanson on 5/5/20.
//  Copyright © 2020 Aaron Hanson. All rights reserved.
//

import UIKit
import Firebase
class MyGamesTableViewController: UITableViewController {
    var currUser: String = ""
    
    //var allBoardGames: [BoardGame] = []
    
    var myCollection: [BoardGame] = []
    var imageDict = Dictionary<String, UIImage>()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
        
        loadGames()
    }

    func loadGames() {
        let collection = Firestore.firestore().collection("users").document(currUser).collection("myCollection")
        collection.getDocuments(){ querySnapshot, error in
            if let err = error {
                print("Error getting documents: \(err)")
            } else {
                self.myCollection = []
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    let game = BoardGame(dict: document.data())
                    game.id = document.documentID
                    self.myCollection.append(game)
                }
                print(self.myCollection.count)
                
            }
            self.tableView.reloadData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        loadGames()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myCollection.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BoardGameCellTableViewCell

        // Configure the cell...
        let game = myCollection[indexPath.row]
        
        cell.gameNameLabel.text = game.name
        cell.bbgRankLabel.text = "BGG Rank: " + game.bbgRank
        cell.publishYearLabel.text = "(" + game.publishYear + ")"
        cell.gameRatingLabel.text = game.rating
        
        let url = URL(string: game.picture)
        let image = try? Data(contentsOf: url!)
        cell.thumbnailView.image = UIImage(data: image!)
        
        return cell
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
        if segue.identifier == "myGamesToSearch" {
            if let vc = segue.destination as? SearchGamesViewController {
                vc.currUser = currUser
            }
        }
        
    }


}
