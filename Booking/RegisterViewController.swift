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
    
    
    var a : [String]  = []
    var b : [String]  = []

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var uniqueIDTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "earth.png")!)
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    //    let db = Firestore.firestore()
    @IBAction func registerPressed(_ sender: UIButton) {
        let db = Firestore.firestore()
        db.collection("Uid").getDocuments { (snapshot, error) in
            if error != nil {
                print("hello:",error!)
            } else {
                for document in (snapshot?.documents)! {
                    
                    if let id = document.data()["id"] as? String {
//                        var mail = document.data()["email"]
                        
                        
                        print("heya:")
                        let typedId = self.uniqueIDTextField.text!
                        
                        if id == typedId{
                            
                            Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (user, error) in
                                if error != nil {
                                    print(error!)
                                }else {
                                   
//                                    mail = self.emailTextField.text!
                                    print("Registration success")
                                    db.collection("Uid").document().setData(["email":"bomma"])
                                    
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
private func retrieveData() {
    let docRef = db.collection("cities").document("SF")

    docRef.getDocument { (document, error) in
        if let document = document, document.exists {
            let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
            print("Document data: \(dataDescription)")
        } else {
            print("Document does not exist")
        }
    }
}
