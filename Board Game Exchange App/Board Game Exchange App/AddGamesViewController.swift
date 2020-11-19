//
//  AddGamesViewController.swift
//  Board Game Exchange App
//
//  Created by Aaron Hanson on 5/7/20.
//  Copyright © 2020 Aaron Hanson. All rights reserved.
//

import UIKit
import Firebase

class AddGamesViewController: UIViewController, XMLParserDelegate {
    
    var currUser: String = ""

    @IBOutlet weak var gameNameLabel: UILabel!
    
    @IBOutlet weak var gameYearLabel: UILabel!
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
                       
    @IBOutlet weak var gameRankLabel: UILabel!
    
    @IBOutlet weak var gameRatingLabel: UILabel!
    
    @IBOutlet weak var gameDescription: UILabel!
    
    var gameTitle = String()
    var yearPublished = String()
    var gameDescript = String()
    var thumbnailImagePath = UIImageView()
    var averageRating = String()
    var bbgRank = String()
    var imageDict = Dictionary<String, UIImage>()
    var gameID: String?
    var elementName: String = String()
    var picturePath: String = String()
    
    @IBOutlet weak var iWantButtonLabel: UIButton!
    
    @IBAction func iWantButtonTapped(_ sender: Any) {
        
        let game = BoardGame(name: gameTitle, picture: picturePath, rank: bbgRank, publish: yearPublished, rating: averageRating, imageView: thumbnailImageView.image!)
               
               addBoardGame(game)
               iWantButtonLabel.setTitle("Game Has Been Added", for: .normal)
               iWantButtonLabel.backgroundColor = .red
        
    
    }
    
    let collection = Firestore.firestore().collection("users")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("gameID in gameinfo View(): " + gameID!)
        let url = URL(string: "https://www.boardgamegeek.com/xmlapi/boardgame/" + gameID! + "?stats=1")
        let semaphore = DispatchSemaphore(value: 0)
        getGames(url: url!, semaphore: semaphore)
        semaphore.wait()
        
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
        sleep(UInt32(2))
        
        gameNameLabel.text = gameTitle
        gameRankLabel.text = "Rating: " + averageRating
        gameRatingLabel.text = "BGG Rank: " + bbgRank
        gameYearLabel.text = "(" + yearPublished + ")"
        gameDescription.text = gameDescript
        thumbnailImageView.image = imageDict[gameTitle]
        
    }
    
    func addBoardGame(_ boardgame: BoardGame) {
        let collection = Firestore.firestore().collection("users").document(currUser).collection("myCollection")
        var ref: DocumentReference?
        ref = collection.addDocument(data: boardgame.toDict()) {error in
            if let err = error {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
                boardgame.id = ref!.documentID
            }
        }
            
    }

    // 1
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
       // boardgameDictionary[elementName] = attributeDict

        if elementName == "rank" {
             bbgRank = attributeDict["value"]!
        }
        if elementName == "boardgame" {
             gameTitle = String()
             yearPublished = String()
             gameDescript = String()
             averageRating = String()
             bbgRank = String()
        }

        self.elementName = elementName
    }
    
    var nameDict: Dictionary<String,String> = [:]
       // 3
       func parser(_ parser: XMLParser, foundCharacters string: String) {
           let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
          
           if (!data.isEmpty) {
              //print(elementName)
               if self.elementName == "yearpublished" {
                   yearPublished = data
               } else if self.elementName == "name" {
                   
                   if(gameTitle == ""){
                       gameTitle = data
                   }
               } else if self.elementName == "description" {
                   gameDescript += data
               }else if self.elementName == "thumbnail" {
                   //print(data)
                   let url = URL(string: data)
                    picturePath = data
                   let image = try? Data(contentsOf: url!)
                   if let imageData = image {
                       let photo = UIImage(data: imageData)
                       self.imageDict[self.gameTitle] = photo
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
