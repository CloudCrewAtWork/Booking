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
    }


}

