//
//  StoreDataMenager.swift
//  IISLocation
//
//  Created by Taras Holets on 21/07/2018.
//  Copyright © 2018 Taras Holets. All rights reserved.
//

import Foundation

class StoreDataMenager {
    
    static let shared = StoreDataMenager()
    
    private let userDefaults = UserDefaults.standard
    private let key = "IISStoredData"
    
    func storeData(position: IISPosition, timestamp: Int) {
        let storeDictionary: [String: Any] = ["latitude": position.doubleLatitude, "longitude": position.doubleLongitude, "timestamp": timestamp]
        
        userDefaults.set(storeDictionary, forKey: key)
    }
    
    func getStoredData() -> (latitude: Double, longitude: Double, timestamp: Int) {
        
        if let storedDictionary = userDefaults.object(forKey: key) as? [String: Any] {
            
            if let latitude = storedDictionary["latitude"] as? Double,
                let longitude = storedDictionary["longitude"] as? Double,
                let timestamp = storedDictionary["timestamp"] as? Int {
                return (latitude, longitude, timestamp)
            }
        }
        
        return (0, 0, 0)
    }
}
