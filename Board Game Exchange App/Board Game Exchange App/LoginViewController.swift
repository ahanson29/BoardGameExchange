//
//  LoginViewController.swift
//  
//
//  Created by Aaron Hanson on 5/2/20.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase

struct userInfo {
    var firstName: String
    var lastName: String
    var age: String
    var region: String
    
}

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var logoImage: UIImageView!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    var firstName: String = ""
    var lastName: String = ""
    var age: String = ""
    var region: String = ""
    var UID: String = ""
    
    let collection = Firestore.firestore().collection("users")
    
    var currUser: String = ""
    
    @IBAction func registerTapped(_ sender: UIButton) {
        messageLabel.isHidden = true
        activityIndicator.startAnimating()
        
//        let email = emailTextField.text
//        let password = passwordTextField.text
        
        
    }
    
    func loginSuccess (){
        activityIndicator.stopAnimating()
        
        performSegue(withIdentifier: "toProfile", sender: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        activityIndicator.stopAnimating()
    }
    
    @IBAction func signinTapped(_ sender: UIButton) {
         messageLabel.isHidden = true
         activityIndicator.startAnimating()
        
         let email = emailTextField.text
         let password = passwordTextField.text
        

        
         Auth.auth().signIn(withEmail: email!, password: password!, completion: {
            authResult, error in
            if let err = error {
                self.messageLabel.text = err.localizedDescription
                self.messageLabel.isHidden = false
                self.activityIndicator.stopAnimating()
            } else{
                self.loginSuccess()
            }
         })
        let user = Auth.auth().currentUser;
        //currUser = user?.email! as! String
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        activityIndicator.stopAnimating()
        messageLabel.isHidden = true
        emailTextField.delegate = self
        passwordTextField.delegate = self
        messageLabel.preferredMaxLayoutWidth = 100
        messageLabel.lineBreakMode = .byWordWrapping
    }
    
    override func viewWillLayoutSubviews() {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }

    
    // MARK: - Navigation
     
     @IBAction func unwindToLogin(_ segue: UIStoryboardSegue) {
         // Sign out current user
        try? Auth.auth().signOut()
     }
     

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toProfile" {
             messageLabel.isHidden = true
             activityIndicator.startAnimating()

            if let vc = segue.destination as? ProfileViewController {
                // Add stuff bro!
                vc.ageFromFirst = age
                vc.nameFromFirst = firstName + " " + lastName
                vc.regionFromFirst = region
                vc.currUser = emailTextField.text!
            }
        }
    }
    

    
    @IBAction func unwindFromAccountSetUp (sender: UIStoryboardSegue){
        let vc = sender.source as! AccountSetUpViewController
       
        //print("message: " + secondVC.newFoodLabel.text!)
        firstName = vc.firstNameTextField.text!
        lastName = vc.lasttNameTextField.text!
        let email = vc.emailTextField.text
        let password = vc.passwordTextField.text
        age = vc.ageTextField.text!
        region = vc.regionTextField.text!
        
        //let newUser = userInfo(firstName: firstName!, lastName: lastName!, age: age!, region: region!)
        //self.user = newUser
        
        UID = email!
        
        Auth.auth().createUser(withEmail: email!,
                               password: password!,
                               completion: {
            authResult, error in
            if let err = error {
                self.messageLabel.text = err.localizedDescription
                self.messageLabel.isHidden = false
                self.activityIndicator.stopAnimating()
            } else{
                //self.loginSuccess()
            }
        })
        
        let newUser = User(name: firstName + " " + lastName, age: age, region: region, profile: "", id: UID)
        currUser = email!
        addUser(newUser)
    }
    
    /*
     
     let newDocumentID = UUID().uuidString
     ref = db.collection("rides").document(newDocumentID).setData([
         "availableSeats": ride.availableSeats,
         "carType": ride.carType,
         "dateCreated": ride.dateCreated,
         "ID": newDocumentID,
     ], merge: true)
     
     */
    
    func addUser(_ user: User) {
        let newDocumentID = UUID().uuidString
        user.id = newDocumentID

        collection.document(newDocumentID).setData(user.toDict()) {error in
            if let err = error {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(newDocumentID)")


            }
        }
    }
    
    
}
