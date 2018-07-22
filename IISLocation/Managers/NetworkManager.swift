//
//  NetworkManager.swift
//  IISLocation
//
//  Created by Taras Holets on 20/07/2018.
//  Copyright © 2018 Taras Holets. All rights reserved.
//

import Alamofire

enum RequestType: String {
    case location = "iss-now.json"
    case astronauts = "astros.json"
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let url = "http://api.open-notify.org/"
    
    func getIISData(of type: RequestType, completionHandler: @escaping(Data?, Error?) -> ()) {
        
        let fullURL = url + type.rawValue
        Alamofire.request(fullURL).responseData { (response) in
            completionHandler(response.data, response.error)
        }
    }
}
