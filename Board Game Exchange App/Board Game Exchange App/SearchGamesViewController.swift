//
//  SearchGamesViewController.swift
//  Board Game Exchange App
//
//  Created by Aaron Hanson on 5/6/20.
//  Copyright © 2020 Aaron Hanson. All rights reserved.
//

import UIKit

class SearchGamesViewController: UIViewController, XMLParserDelegate  {
    var currUser: String = ""

    @IBOutlet weak var searchFieldLabel: UITextField!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBAction func searchTapped(_ sender: Any) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        messageLabel.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        messageLabel.isHidden = true
    }

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        
        if segue.identifier == "toAddGames" {
            if let vc = segue.destination as? SearchGamesToAddTableViewController {
                vc.searchTerm = searchFieldLabel.text!
                vc.currUser = currUser
            }
        }
        
    }
  

}
