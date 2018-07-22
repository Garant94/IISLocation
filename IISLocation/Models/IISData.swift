//
//  IISData.swift
//  IISLocation
//
//  Created by Taras Holets on 20/07/2018.
//  Copyright © 2018 Taras Holets. All rights reserved.
//
import Foundation

class IISData: Decodable {
    
    enum IISDataKeys: String, CodingKey {
        case message
        case iisPosition = "iss_position"
        case timestamp
    }
    
    let message: String
    let iISPosition: IISPosition
    let timestamp: Int
    
    init(message: String, iisPosition: IISPosition, timestamp: Int) {
        self.message = message
        self.iISPosition = iisPosition
        self.timestamp = timestamp
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: IISDataKeys.self)
        message = try container.decode(String.self, forKey: .message)
        iISPosition = try container.decode(IISPosition.self, forKey: .iisPosition)
        timestamp = try container.decode(Int.self, forKey: .timestamp)
        
    }
    
    var timeString: String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
    
}

class IISPosition: Decodable {
   
    let latitude: String
    let longitude: String
    
    init(latitude: String, longitude: String) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    var doubleLatitude: Double {
        return Double(latitude)?.rounded(toPlaces: 4) ?? 0
    }
    
    var doubleLongitude: Double {
        return Double(longitude)?.rounded(toPlaces: 4) ?? 0
    }
}
