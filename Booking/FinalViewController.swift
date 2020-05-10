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
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func bookASlot(_ sender: UIButton) {
        
        
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = df.string(from: date)

        let userID = Auth.auth().currentUser?.email!
        db.collection("Users").whereField("email", isEqualTo: userID as Any )
           .getDocuments() { (querySnapshot, err) in
               if let err = err {
                   print("Error getting documents: \(err)")
               } else {
                   for document in querySnapshot!.documents {
                    
//                    print("\(document.get("uniqueId")))")
                    let name = document.documentID
                    let id = document.get("uniqueId")!
                    print(id)
                    // creatin TimeSlots DataBase
<<<<<<< HEAD
<<<<<<< HEAD
                    db.collection("TimeSlots").whereField("name", isEqualTo: name).getDocuments() { (querySnapshot, err) in
=======
                    db.collection("TimeSlots").whereField("name", isEqualTo: document.documentID).getDocuments() { (querySnapshot, err) in
>>>>>>> parent of 10cfc73... Update FinalViewController.swift
=======
                    db.collection("TimeSlots").whereField("name", isEqualTo: document.documentID).getDocuments() { (querySnapshot, err) in
>>>>>>> parent of 10cfc73... Update FinalViewController.swift
                    if let err = err {
                        //maybe connection problem
                        print("error retrieving documents \(err)")
                    } else {
                        if (querySnapshot?.count != 0) {
                            //query was succesful, but is empty -> uid not found
<<<<<<< HEAD
<<<<<<< HEAD
                            print("You have already booked a slot")
=======
                            print("Uid not valid")
>>>>>>> parent of 10cfc73... Update FinalViewController.swift
=======
                            print("Uid not valid")
>>>>>>> parent of 10cfc73... Update FinalViewController.swift
                        }else{
                            db.collection("TimeSlots").document(name).setData([
                            "name": document.documentID,
                            "time": dateString,
                            "uniqueId": document.get("uniqueId") as Any
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
//private func getDocument() {
//    //Get specific document from current user
//    let docRef = Firestore.firestore().collection("Users").document(Auth.auth().currentUser?.uid ?? "")
//
//    // Get data
//    docRef.getDocument { (document, error) in
//        if let document = document, document.exists {
//            let dataDescription = document.data()
//            print(dataDescription?["email"] as Any)
//        } else {
//            print("Document does not exist")
//        }
//    }
//}

