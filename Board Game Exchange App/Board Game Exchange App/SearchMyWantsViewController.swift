//
//  SearchMyWantsViewController.swift
//  Board Game Exchange App
//
//  Created by Aaron Hanson on 5/6/20.
//  Copyright © 2020 Aaron Hanson. All rights reserved.
//

import UIKit

class SearchMyWantsViewController: UIViewController {

    var currUser: String = ""
    
    @IBOutlet weak var searchTextField: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationItem.title = "Change here"
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.identifier == "fromMySearchToMyResults" {
           if let vc = segue.destination as? AddMyWantsTableViewController {
            vc.searchTerm = searchTextField.text!
            vc.currUser = currUser
        }
       }
    }
    

}
