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
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    //    let db = Firestore.firestore()
    @IBAction func registerPressed(_ sender: UIButton) {
//        retrieveData()
        let c = User.init(email: emailTextField.text!, name: usernameTextField.text!, id: uniqueIDTextField.text!)
        let db = Firestore.firestore()
        db.collection("Uid").getDocuments { (snapshot, error) in
            if error != nil {
                print("hello:",error!)
            } else {
                db.collection("Users").getDocuments { (snapshot, error)in
                    if error != nil{
                        print("secondLevel error:",error!)
                    }else {
                        for document in (snapshot?.documents)! {
                            
                            
                            if let id = document.data()["id"] as? String, let uid = document.data()["uniqueId"] as? String {
                                
                                
                                
                                let typedId = self.uniqueIDTextField.text!
                                
                                if id == typedId && typedId != uid{
                                    
                                    Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (user, error) in
                                        if error != nil {
                                            print(error!)
                                        }else {
                                            // Add a new document in collection "cities"
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
                                            
                                            //                                    mail = self.emailTextField.text!
                                            print("Registration success")
                                            
                                            
                                            //SVProgressHUD.dismiss()
                                            
                                            self.performSegue(withIdentifier: "goToBooking", sender: self)
                                            
                                
                                        }
                                    }
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                }
                
                
            }
        }
    }
}


