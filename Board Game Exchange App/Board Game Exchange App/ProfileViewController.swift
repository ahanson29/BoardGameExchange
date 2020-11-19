//
//  ProfileViewController.swift
//  Board Game Exchange App
//
//  Created by Aaron Hanson on 5/2/20.
//  Copyright © 2020 Aaron Hanson. All rights reserved.
//
import Foundation
import UIKit
import Firebase
import SwiftCSV

class ProfileViewController: UIViewController {

    var imageArray: [UIImageView] = []
    var imagePaths: [String] = []
    var allBoardGames: [BoardGame] = []
    var currUser: String = ""
    
    var nameFromFirst: String = ""
    var ageFromFirst: String = ""
    var regionFromFirst: String = ""
    
    @IBOutlet weak var profilePicView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var ageLabel: UILabel!
    
    @IBOutlet weak var regionLabel: UILabel!
    
    var collection = Firestore.firestore().collection("users")
    
    @IBAction func addPictureTapped(_ sender: UIButton) {
     
            self.uploadImage()

    }
    
    
    
    let storage = Storage.storage()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = nameFromFirst
        ageLabel.text = ageFromFirst
        regionLabel.text = regionFromFirst
        
    }
    
    func loadGames() {
        let documents = collection.document(currUser).collection("myBoardGames")
        documents.getDocuments(){ querySnapshot, error in
            if let err = error {
                print("Error getting documents: \(err)")
            } else {
                self.allBoardGames = []
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    let game = BoardGame(dict: document.data())
                    game.id = document.documentID
                    self.allBoardGames.append(game)
                }
                print(self.allBoardGames.count)
                // relaod data
            }

        }
    }

    func addUser(_ player: BoardGame) {
        //collection = Firestore.firestore().collection(currUser)
//        var ref: DocumentReference?
//        ref = collection.addDocument(data: player.toDict()) {error in
//            if let err = error {
//                print("Error adding document: \(err)")
//            } else {
//                print("Document added with ID: \(ref!.documentID)")
//                player.id = ref!.documentID
//            }
//        }
            
    }
    

    func uploadImage() {
           let image = imageArray[0]
           guard let thisImage = image.image, let data = thisImage.jpegData(compressionQuality: 1.0) else {
               //presentAlert(title: "Error", message: "Something went wrong, dummy!")
               print("Something went wrong, dummy!")
               return
           }
           
           let imageName = imagePaths[0]
           
           let imageReference = Storage.storage().reference()
               .child("pictures").child(imageName)
           
           imageReference.putData(data, metadata: nil) { (metadata, err) in
               if let err = err {
                   //self.presentAlert(title: "Error", message: err.localizedDescription)
                   print(err.localizedDescription)
                   return
               }
           
               imageReference.downloadURL(completion: {(url, err) in
                   if let err = err {
                       print(err.localizedDescription)
                   }
                   guard let url = url else {
                       print("Something when wrong")
                       return
                   }
                   
                   let dataReference = Firestore.firestore().collection("images").document()
                   let documentUid = dataReference.documentID
                   let urlString = url.absoluteString
                   
                   let data = [
                       "image": urlString,
                       "id": documentUid
                   ]
                   
                   dataReference.setData(data, completion: {(err) in
                       if let err = err {
                           print(err.localizedDescription)
                           return
                       }
                       //self.imageView.image = UIImage()
                       print("Successfully saved image to database!")
                       
                   })
                   
               })
           }
           imageArray.remove(at: 0)
           imagePaths.remove(at: 0)
           print("All done")
       }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ProfiletoMyWants" {
            if let vc = segue.destination as? MyWantsTableViewController {
                vc.currUser = self.currUser
            }
        }
        if segue.identifier == "profileToCollection" {
            if let vc = segue.destination as? MyGamesTableViewController {
                vc.currUser = self.currUser
            }
        }
        if segue.identifier == "fromProfiletoSellTrade" {
            if let vc = segue.destination as? MySellTradeTableViewController {
                vc.currUser = self.currUser
            }
        }
    }
    

}
