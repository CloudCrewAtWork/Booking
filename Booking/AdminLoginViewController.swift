//
//  AdminLoginViewController.swift
//  Booking
//
//  Created by SAI ANURAG DODDI on 12/05/20.
//  Copyright © 2020 SAI ANURAG DODDI. All rights reserved.
//

import UIKit
import Firebase

class AdminLoginViewController: UIViewController {
    
    @IBOutlet weak var adminIdTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "earth.png")!)

        
    }
    
    @IBAction func adminLoginPressed(_ sender: UIButton) {
        
        
        db.collection("AdminId").whereField("Aid", isEqualTo: adminIdTextField.text!  )
        .getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                if querySnapshot?.count == 1{
                    
                    self.performSegue(withIdentifier: "adminHomePage", sender: self)
                    print("document found")

                    
                }else{
                    print("document not found")
                }
//                self.performSegue(withIdentifier: "adminHomePage", sender: self)


            }

        }
        
        
        
        
        
        
        
    }
    
    
    
    
    
}
