//
//  UniqueIdManager.swift
//  Booking
//
//  Created by SAI ANURAG DODDI on 08/05/20.
//  Copyright © 2020 SAI ANURAG DODDI. All rights reserved.
//

import Foundation


protocol UniqueIdManagerDelegate {
    func didUpdateId(id: String)
    func didFailWithError(error:Error)
    
}

//protocol CoinManagerDelegate {
//    func didUpdateCoin(price: String, currency:String)
//
//}

struct UniqueIdManager {
    var delegate: UniqueIdManagerDelegate?
    
    let baseURL = "https://sheetsu.com/apis/v1.0su/0ce1584356b4"
    
    
    
    
    func getUniqueId(for id: String){
        
        let urlString = baseURL
        
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safedata = data{
                    if let bitCoinPrice = self.parseJSON(safedata){
                        let priceString = String(bitCoinPrice)
                        self.delegate?.didUpdateId(id: priceString)
                        
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data:Data) -> String? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(IdData.self, from: data)
            let Wid = decodedData.id
            
            return Wid
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
