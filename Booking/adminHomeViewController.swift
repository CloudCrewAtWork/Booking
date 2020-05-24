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
    
    
    var c = 0
   
    var time1 : Date?
    var time2 : Date?
    var a : [QueryDocumentSnapshot]?
    
    
    @IBOutlet weak var openingTimeSet: UITextField!
    @IBOutlet weak var closingTimeSet: UITextField!
    @IBOutlet weak var eachSlotTiming: UITextField!
    @IBOutlet weak var peoplePerSlotSet: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "earth.png")!)
        navigationItem.hidesBackButton = true
//        db.collection("Count").ge
        
        //        let formatter = DateComponentsFormatter()
        //        formatter.allowedUnits = [.hour, .minute]
        
    }
    
    @IBAction func viewSlotsPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "listViewSegue", sender: self)
        
        
        
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
        //        createCounter(ref: db.collection("TimeSlots").document(), numShards: 1)
    }
    
    
    @IBAction func setFieldsPressed(_ sender: UIButton) {
        let openTime = openingTimeSet.text!
        let closeTime = closingTimeSet.text!
        let eachSlotTime = eachSlotTiming.text!
        let personPerSlot = peoplePerSlotSet.text!
        
       
        
        
        if (openTime != "" && closeTime != "" && eachSlotTime != "" && personPerSlot != ""){
            
            
            let timeFormatter = DateFormatter()
              timeFormatter.timeStyle = .short
              timeFormatter.dateFormat = "HH:mm"
              time1 = timeFormatter.date(from: openingTimeSet.text!)
              time2 = timeFormatter.date(from: closingTimeSet.text!)
              
              
              let formatter = DateComponentsFormatter()
              formatter.allowedUnits = [.hour, .minute]
              print(formatter.string(from: time1!, to: time2!)!)
            
              
              
              
              print(time1! , time2!)
              let interval = time2?.timeIntervalSince(time1!)
              print(interval!)
              
              c = Int(interval!)
            
            db.collection("Scheduler").document("VariousFields").setData([
//                "OpenTime"  :   time1!,
//                "CloseTime" : time2!,
                "eachSlotTime" : Int(eachSlotTime)!,
                "personPerSlot" : Int(personPerSlot)!,
                "MaxPeopleLimit" : (c/3600)*Int(personPerSlot)!
            ])
            
            
            
            
            
        }else{
            let alert = UIAlertController(title: "Alert", message: "Please fill all the fields!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            print("Please fill all the fields!")
        }
        
        openingTimeSet.text = ""
        closingTimeSet.text = ""
        eachSlotTiming.text = ""
        peoplePerSlotSet.text = ""
        
    }
    
    
    
    
}
private func deleteDocument(){
    //    var docCount = 0
    db.collection("Count").document("count").setData(["log" : 0])
    
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
//func createCounter(ref: DocumentReference, numShards: Int) {
//    ref.setData(["numShards": numShards]){ (err) in
//        for i in 0...numShards {
//            ref.collection("shards").document(String(i)).setData(["count": 0])
//        }
//    }
//}


