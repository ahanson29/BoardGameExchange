//
//  AddGamesTableViewController.swift
//  Board Game Exchange App
//
//  Created by Aaron Hanson on 5/5/20.
//  Copyright © 2020 Aaron Hanson. All rights reserved.
//

import UIKit

struct Book {
    var bookTitle: String
    var bookAuthor: String
}

struct Boardgame {
    var gameID: String
    var gameTitle: String
    var yearPublished: String
    var gameDescription: String
    var thumbnailImagePath: UIImageView
    var averageRating: String
    var bbgRank: String
}

class AddGamesTableViewController: UITableViewController, XMLParserDelegate  {
    var currUser: String = ""
    
    var books: [Book] = []
    var elementName: String = String()
    var bookTitle = String()
    var bookAuthor = String()
    
    var gameID = String()
     var gameTitle = String()
     var yearPublished = String()
     var gameDescription = String()
     var thumbnailImagePath = UIImageView()
     var averageRating = String()
     var bbgRank = String()
     var imageDict = Dictionary<String, UIImage>()
     var boardgameDictionary: Dictionary<String, Dictionary<String,String>> = [:]
    
    var myAddedBoardGames: [Boardgame] = []
    
    var searchedGames: [Boardgame] = []
    
    var searchTerm = ""
    var gameIDList: [String] = []
    var flag: Bool = false
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
        
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
        print(url)

        let semaphore = DispatchSemaphore(value: 0)
        let searchURL = URL(string: url)
        flag = false
        getGameIds(url: searchURL!, semaphore: semaphore)
        semaphore.wait()
        sleep(UInt32(1.0))
        flag = true
        for id in gameIDList {
            let url = URL(string: "https://www.boardgamegeek.com/xmlapi/boardgame/\(id)?stats=1")
            gameID = id
            getGames(url: url!, semaphore: semaphore)
            gameIDList.remove(at: 0)
            semaphore.wait()
        }

    }
    
    func getGameIds(url: URL, semaphore: DispatchSemaphore) {
        print("in getGameIds()")
        let task = URLSession.shared.dataTask(with: url as URL) {(data, response, error) in
            semaphore.signal()
            print("before getGameIds() closure")
            if let parser = XMLParser(contentsOf: url) {
                parser.delegate = self
                parser.parse()
            }
        }
        task.resume()
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
        if searchedGames.count > 50{
            return 50
        }else{
             return searchedGames.count
        }
       
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchGame", for: indexPath) as! AddingGamesTableViewCell

        // Configure the cell...
        let game = searchedGames[indexPath.row]
            //cell.gameDescription = game.gameDescription
            cell.gameID = game.gameID
            cell.gameNameLabel.text = game.gameTitle
           // cell.rankLabel.text = game.bbgRank
           // cell.ratingLabel.text = game.averageRating
            cell.yearLabel.text = "(" + game.yearPublished + ")"
            //cell.thumbnailView.image = imageDict[game.gameTitle]

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
    
    var nameCounter = 0
    var nameAt = 0
    var newCounter = 0
    // 1
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
       // boardgameDictionary[elementName] = attributeDict
        if elementName == "book" {
            bookTitle = String()
            bookAuthor = String()
        }
        if elementName == "rank" {
           //print(attributeDict)
             //print(attributeDict["value"]!)
            bbgRank = "Game Rank: " + attributeDict["value"]!
        }
        
        if elementName == "boardgame" {
            if self.flag == false{
           //     print(attributeDict["objectid"]!)
                gameID = attributeDict["objectid"]!
                self.gameIDList.append(gameID)
                print(self.gameIDList[self.gameIDList.count - 1])
            }
        }
        
        if elementName == "boardgame" {
               // gameID = String()
                gameTitle = String()
                yearPublished = String()
                gameDescription = String()
                averageRating = String()
                bbgRank = String()
                //gameIDList = []

        }

        self.elementName = elementName
    }

    // 2
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "book" {
            let book = Book(bookTitle: bookTitle, bookAuthor: bookAuthor)
                books.append(book)
        }
        if elementName == "boardgame" {
          //  print("inserting boardgame into list")
                let game = Boardgame(gameID: gameID, gameTitle: gameTitle, yearPublished: yearPublished, gameDescription: gameDescription, thumbnailImagePath: thumbnailImagePath, averageRating: averageRating, bbgRank: bbgRank)
                if(gameTitle != "" && flag == true){
                    searchedGames.append(game)
                }
            
        }
    }
    var nameDict: Dictionary<String,String> = [:]
    // 3
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if (!data.isEmpty) {
            if self.elementName == "title" {
                bookTitle += data
            } else if self.elementName == "author" {
                bookAuthor += data
            }
        }
        if (!data.isEmpty) {
           //print(elementName)
            if self.elementName == "yearpublished" {
                yearPublished = data
            } else if self.elementName == "name" {
                
                if(gameTitle == ""){
                    gameTitle = data
                }
            } else if self.elementName == "description" {
                gameDescription += data
            }else if self.elementName == "thumbnail" {
                //print(data)
                let url = URL(string: data)
                let image = try? Data(contentsOf: url!)
                if let imageData = image {
                    let photo = UIImage(data: imageData)
                    self.imageDict[self.gameTitle] = photo
                    //self.thumbnailImagePath.image = photo
                }
            }else if self.elementName == "average" {
                //print(data)
                let rating = data as NSString
                let ratingFloat = Float(rating as String)
                
                let formatter = NumberFormatter()
                formatter.minimumFractionDigits = 0
                formatter.maximumFractionDigits = 1

                // Avoid not getting a zero on numbers lower than 1
                // Eg: .5, .67, etc...
                formatter.numberStyle = .decimal
                
                averageRating =  formatter.string(from: ratingFloat! as NSNumber)!
            }else if self.elementName == "ranks" {
                //print("DUBUG in ranks")
                //print(data)
                //bbgRank = boardgameDictionary["ranks"]!["value"]!
                //print(bbgRank)
            }
            
        
        }
        
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
