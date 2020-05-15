//
//  RegisterViewController.swift
//  Booking
//
//  Created by SAI ANURAG DODDI on 06/05/20.
//  Copyright © 2020 SAI ANURAG DODDI. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var uniqueIDTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "earth.png")!)
        
    }
    
    //    let db = Firestore.firestore()
    @IBAction func registerPressed(_ sender: UIButton) {
        //        retrieveData()
        let c = User.init(email: emailTextField.text!, name: usernameTextField.text!, id: uniqueIDTextField.text!)
        let db = Firestore.firestore()
        
        db.collection("Uid").whereField("id", isEqualTo: c.id).getDocuments() { (querySnapshot, err) in
                if let err = err {
                    //maybe connection problem
                    print("error retrieving documents \(err)")
                } else {
                    if (querySnapshot?.count == 0) {
                        //query was succesful, but is empty -> uid not found
                        let alert = UIAlertController(title: "Alert", message: "UniqueId Not Found", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        print("Uid not valid")
                    } else {
                        //Found Uid in collection -> UId valid
                        //go on in registration process
                        db.collection("Users").whereField("uniqueId", isEqualTo: c.id)
                            .getDocuments() { (querySnapshot, err) in
                                if let err = err {
                                    //maybe connection problem
                                    print("Error getting documents: \(err)")
                                } else {
                                    if (querySnapshot?.count == 0) {
                                        // search result is empty -> no active user with provided id -> register !
                                        Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { user, error in
                                            if (error != nil) {
                                                print("Error  creating user")
                                            } else {
                                                print("Registration success")
//                                                let alert = UIAlertController(title: "Alert", message: "Registration Successful", preferredStyle: UIAlertController.Style.alert)
//                                                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
//                                                self.present(alert, animated: true, completion: nil)
                                                self.performSegue(withIdentifier: "goToBooking", sender: self)
                                                
                                                db.collection("Users").document(c.name).setData([
                                                    "name": c.name,
                                                    "email": c.email,
                                                    "uniqueId": c.id
                                                ]) { err in
                                                    if let err = err {
                                                        print("Error writing document: \(err)")
                                                    } else {
                                                        print("Document successfully written!")
                                                    }
                                                }
                                            }
                                            
                                        }
                                    }
                                    else {
                                        //search result found a user who has the provided id -> invalid
                                        let alert = UIAlertController(title: "Alert", message: "ID already taken", preferredStyle: UIAlertController.Style.alert)
                                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                        self.present(alert, animated: true, completion: nil)
                                        print("ID alreay taken")
                                    }
                                }
                        }
                    }
                }
        }
        
    }
}


