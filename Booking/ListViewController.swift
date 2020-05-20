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
            return listArray.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
    //        let job = listArray[indexPath.row]
            cell.userName.text = "Hello"
            
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
                            self.listArray.append(data)
                            print(self.listArray.count)
//                            print(doc.get("name")!,":",doc.get("uniqueId")!)
                        
                        }
                    }
                    
                }

        // Do any additional setup after loading the view.
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
