//
//  FinalViewController.swift
//  Booking
//
//  Created by SAI ANURAG DODDI on 06/05/20.
//  Copyright © 2020 SAI ANURAG DODDI. All rights reserved.
//

import UIKit
import Firebase

class FinalViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "earth.png")!)
        navigationItem.hidesBackButton = true
        
    }
    
    @IBAction func bookASlot(_ sender: UIButton) {
        
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = df.string(from: date)
        let userMail = Auth.auth().currentUser?.email!
        //search user table for entry that matches the current users email
        db.collection("Users").whereField("email", isEqualTo: userMail as Any )
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    //if we are here there can be only ONE user with this email adress, since we are logged in
                    //so the array with our search results can contain only one entry
                    let document = querySnapshot?.documents[0]
                    let name = document?.documentID
                    let id = document?.get("uniqueId")
                    
                    db.collection("TimeSlots")
                        .whereField("name", isEqualTo: name!)
                        .getDocuments { (querySnapshot, err) in
                            if let error = err {
                                print(error)
                            } else {
                                //there can, if any, only be one prior booking
                                if (querySnapshot?.count == 0) {
                                    //None found -> book slot
                                    db.collection("TimeSlots").document(name!).setData([
                                        "name": name as Any,
                                        "time": dateString,
                                        "uniqueId": id!
                                    ]) { err in
                                        if let err = err {
                                            print("Could not book because of: \(err)")
                                        } else {
                                            print("Slot booked!")
                                        }
                                    }
                                } else {
                                    print("already booked")
                                }
                            }
                    }
                }
        }
    }
    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}
