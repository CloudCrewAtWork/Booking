//
//  ListViewController.swift
//  Booking
//
//  Created by SAI ANURAG DODDI on 21/05/20.
//  Copyright © 2020 SAI ANURAG DODDI. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var listArray = [ListDetail]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(listArray.count)
        return listArray.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
            let job = listArray[indexPath.row]
            cell.userName.text = String(indexPath.row+1) + " " + job.Uname! + job.id!
            cell.uniqueId.text = String(job.slotNumber!)
//            cell.userName.text = "Hello"

            return cell
        }
    

    @IBOutlet weak var listTable: UITableView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        listTable.delegate = self
        listTable.dataSource = self
        
        db.collection("TimeSlots").order(by: "time").getDocuments(){(querySnapshot,err) in
                    if err != nil{
                        print(err!)
                    }else{
                        for doc in querySnapshot!.documents{
                            
                            let data = ListDetail()
                            data.Uname = doc.get("name") as? String
                            data.id = doc.get("uniqueId") as? String
                            data.slotNumber = doc.get("SlotDetail") as? Int
                            self.listArray.append(data)
                            print(doc.get("name")!,":",doc.get("uniqueId")!)
                        
                        }
                        DispatchQueue.main.async
                                   {
                                       self.listTable.reloadData()
                                   }
                    }
           
                    
                }
        print("Hello",listArray.count)
//        print(self.listArray.count)


        // Do any additional setup after loading the view.
    }


}
