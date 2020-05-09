//
//  User.swift
//  Booking
//
//  Created by SAI ANURAG DODDI on 09/05/20.
//  Copyright © 2020 SAI ANURAG DODDI. All rights reserved.
//

import Foundation
import Firebase

struct User{
    let email: String
    let name: String
    let id: String
}
let db = Firestore.firestore()

