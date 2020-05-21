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
    
    
    
    

    
   
    
    
    @IBOutlet weak var timeDisplay: UILabel!
    @IBOutlet weak var bookASlot: UIButton!
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "earth.png")!)
        navigationItem.hidesBackButton = true
        
            //if the required number of slots are filled disable the Book a slot button and print it to the scree
        db.collection("Count").whereField("log", isLessThanOrEqualTo: 4 )
            .getDocuments()  { (arrayCount, err) in 
                if err != nil {
                    print("Error getting documents: \(String(describing: err))")
                } else {
                    if(arrayCount?.count == 0){
//                        self.bookASlot.isHidden = true
                        self.bookASlot.isEnabled = false
//                        self.alertBox.text = "All slots for the day are booked please try later"
                        let alert = UIAlertController(title: "Alert", message: "All slots for the day are booked please try later", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        
                    }else{
                        print("something")
                    }
                }
        }
        
        
    }
    
    @IBOutlet weak var alertBox: UILabel!
    @IBAction func bookASlot(_ sender: UIButton) {
//        let h = totalPersonLimit()
//        print("MaxPeopleLimit: ",h)
        var serialNumber = 0
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        df.timeZone = NSTimeZone(name: "UTC") as TimeZone?
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
                                
                                //MARK: - To get the position of the document and displaying the slots accordingly
                                
                                db.collection("TimeSlots").whereField("written", isEqualTo: true)
                                                .getDocuments()  { (arrayCount, err) in
                                                    if err != nil {
                                                        print("Error getting documents: \(String(describing: err))")
                                                    } else {

                                                        for _ in arrayCount!.documents {
                                                            
                                                            serialNumber += 1
                                                            
                                                        }
                                                        
                                                        print("userNumber:",serialNumber)
                                                        
                                                    }
                                            }
                                
                                //there can, if any, only be one prior booking
                                if (querySnapshot?.count == 0) {
                                    //None found -> book slot
                                    db.collection("TimeSlots").document(name!).setData([
                                        
                                        "name": name! as Any,
                                        "time": dateString,
                                        "uniqueId": id!,
                                        "written": true,
                                        "SlotDetail" : 0,
                                        "email" : Auth.auth().currentUser?.email! as Any
                                        
                                    ]) { err in
                                        if let err = err {
                                            self.alertBox.text = "Could not book because of: \(err)"
                                            print("Could not book because of: \(err)")
                                            
                                        } else {
                                            // Incrementing the count value as soon as a new slot is booked (IT GIVES US THE TOTAL NUMBER OF SLOTS BOOKED VALUE)
                                            db.collection("Count").document("count").updateData(["log" : FieldValue.increment(Int64(1))])
                                            self.alertBox.text = "Slot booked! SlotNo: \((serialNumber/15)+1)"
                                            print("Slot booked!")
                                            
                                            //trying to add slot details
                                            
                                            let currentUser = Auth.auth().currentUser?.email!
                                            db.collection("TimeSlots").whereField("email", isEqualTo: currentUser!).getDocuments(){ (querySnapshot, err) in
                                            if let err = err {
                                                print("Error getting documents: \(err)")
                                            } else {

                                                db.collection("TimeSlots").document(name!).updateData(["SlotDetail" : (serialNumber/15)+1])

                                                }
                                            }
                                        
                                            let alert = UIAlertController(title: "Alert", message: "Slot Booked! SlotNo: \((serialNumber/15)+1)", preferredStyle: UIAlertController.Style.alert)
                                            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                            self.present(alert, animated: true, completion: nil)
                                        }
                                    }
                                } else {
                                    self.alertBox.text = "already booked"
                                    print("already booked")
                                    let alert = UIAlertController(title: "Alert", message: "You Already Booked A Slot", preferredStyle: UIAlertController.Style.alert)
                                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                    self.present(alert, animated: true, completion: nil)
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


