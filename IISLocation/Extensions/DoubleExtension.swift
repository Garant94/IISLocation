//
//  DoubleExtension.swift
//  IISLocation
//
//  Created by Taras Holets on 21/07/2018.
//  Copyright © 2018 Taras Holets. All rights reserved.
//

import Foundation

extension Double {
    
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
}
