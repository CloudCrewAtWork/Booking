//
//  adminHomeViewController.swift
//  Booking
//
//  Created by SAI ANURAG DODDI on 12/05/20.
//  Copyright © 2020 SAI ANURAG DODDI. All rights reserved.
//

import UIKit
import Firebase

class adminHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "earth.png")!)
        navigationItem.hidesBackButton = true

    }
    

    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        
        do {
                try Auth.auth().signOut()
                navigationController?.popToRootViewController(animated: true)
                
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
        
    }
    
    @IBAction func deleteSlotPressed(_ sender: UIButton) {
        
        deleteDocument()
    }
    
}
private func deleteDocument(){
//    var docCount = 0

    db.collection("TimeSlots").whereField("written", isEqualTo: true)
    .getDocuments() { (querySnapshot, err) in
        if err != nil {
            print("Error getting documents: (err)")
        } else {
            for document in querySnapshot!.documents {
                let c = document.documentID
                db.collection("TimeSlots").document(c).delete()
            }
//            docCount = querySnapshot?.count as! Int
//            print(docCount)

        }
}
}
