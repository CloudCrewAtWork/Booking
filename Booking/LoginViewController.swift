//
//  LoginViewController.swift
//  Booking
//
//  Created by SAI ANURAG DODDI on 06/05/20.
//  Copyright © 2020 SAI ANURAG DODDI. All rights reserved.
//

import UIKit
import Firebase


class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "earth.png")!)

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func logInPressed(_ sender: UIButton) {
        
        //SVProgressHUD.show()
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            
            
            if error != nil {
                print(error!)
//                SVProgressHUD.showError(withStatus: "Email or password incorrect")
            } else {
                print("Login successful")
                
//                SVProgressHUD.dismiss()
                
                self.performSegue(withIdentifier: "goToBooking", sender: self)
            }
        }
    }
    
}
