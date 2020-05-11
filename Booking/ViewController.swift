//
//  ViewController.swift
//  Booking
//
//  Created by SAI ANURAG DODDI on 06/05/20.
//  Copyright © 2020 SAI ANURAG DODDI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "earth.png")!)
        // Do any additional setup after loading the view.
        exampleData()
//        deleteDocument()
        
    }


}

private func deleteDocument(){
    var docCount = 0

    db.collection("TimeSlots").whereField("written", isEqualTo: true)
    .getDocuments() { (querySnapshot, err) in
        if err != nil {
            print("Error getting documents: (err)")
        } else {
            for document in querySnapshot!.documents {
                docCount = querySnapshot?.count as! Int
                let c = document.documentID
                db.collection("TimeSlots").document(c).delete()
            }
            print(docCount)
        
        }
}
}

private func exampleData() {
    // [START example_data]
    let citiesRef = db.collection("cities")
    db.collection("cities").document("LA").delete()

//    citiesRef.document("SF").setData([
//        "name": "San Francisco",
//        "state": "CA",
//        "country": "USA",
//        "capital": false,
//        "population": 860000,
//        "regions": ["west_coast", "norcal"]
//        ])
    citiesRef.document("LA").setData([
        "name": "Los Angeles",
        "state": "CA",
        "country": "USA",
        "capital": false,
        "population": 3900000,
        "regions": ["west_coast", "socal"]
        ])
    citiesRef.document("DC").setData([
        "name": "Washington D.C.",
        "country": "USA",
        "capital": true,
        "population": 680000,
        "regions": ["east_coast"]
        ])
    citiesRef.document("TOK").setData([
        "name": "Tokyo",
        "country": "Japan",
        "capital": true,
        "population": 9000000,
        "regions": ["kanto", "honshu"]
        ])
    citiesRef.document("BJ").setData([
        "name": "Beijing",
        "country": "China",
        "capital": true,
        "population": 21500000,
        "regions": ["jingjinji", "hebei"]
        ])
    // [END example_data]
}

