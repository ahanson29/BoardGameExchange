//
//  AddMyWantsTableViewController.swift
//  Board Game Exchange App
//
//  Created by Aaron Hanson on 5/6/20.
//  Copyright © 2020 Aaron Hanson. All rights reserved.
//

import UIKit

struct QuickGame{
    var gameTitle: String
    var gameYear: String
    var gameID: String
}

class AddMyWantsTableViewController: UITableViewController, XMLParserDelegate {

    var currUser: String = ""
    
    var searchedGames: [QuickGame] = []
    var gameName: String?
    var gameYear: String?
    var elementName: String = String()
    var gameID:String?
    

    
    var searchTerm: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 75
        let search = searchTerm.components(separatedBy: " ")
        var url = "http://www.boardgamegeek.com/xmlapi/search?search="
        
        var count = 0
        for term in search {
            if search.count == 1 {
                url += term
            }
            else if count == search.count - 1 {
                url += term
            } else {
                url += "%20"
            }
            count += 1
        }
    
        
        let semaphore = DispatchSemaphore(value: 0)
        let searchURL = URL(string: url)
        getGames(url: searchURL!, semaphore: semaphore)
        semaphore.wait()
        sleep(UInt32(3.0))
        print(searchedGames.count)
        
    }
    
    func getGames(url: URL, semaphore: DispatchSemaphore) {
        
        let task = URLSession.shared.dataTask(with: url as URL) {(data, response, error) in
            semaphore.signal()
            if let parser = XMLParser(contentsOf: url) {
                parser.delegate = self
                parser.parse()
            }
        }
        task.resume()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchedGames.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myWantSearchCell", for: indexPath) as! MyWantCell

        // Configure the cell...
        let game = searchedGames[indexPath.row]
        
        cell.nameLabel.text = game.gameTitle
        cell.yearLabel.text = game.gameYear
        cell.gameID = game.gameID

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
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        gameID = searchedGames[indexPath.row].gameID
//       // performSegue(withIdentifier: "fromMySearchToDetails", sender: nil)
//
//    }
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    
    // 1
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {

        if elementName == "boardgame" {
            print("In 1st parser boardgame")
            gameName = String()
            gameYear = String()
            gameID = attributeDict["objectid"]
        }

        self.elementName = elementName
    }

    // 2
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "boardgame" {
            print("In 2nd parser boardgame")
            let game = QuickGame(gameTitle: gameName!, gameYear: gameYear!, gameID: gameID!)
            searchedGames.append(game)
        }
    }

    // 3
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

        if (!data.isEmpty) {
            if self.elementName == "name" {
                print("In 3rd parser name")
                gameName! += data
            } else if self.elementName == "yearpublished" {
                gameYear! += data
                print("In 3rd parser yearpublished")
            }
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "fromMySearchToDetails" {
            
            if let vc = segue.destination as? MyResultsViewController {
                let cell = sender as! MyWantCell
                vc.gameID = cell.gameID
                vc.currUser = currUser
            }
        }
    }


}
