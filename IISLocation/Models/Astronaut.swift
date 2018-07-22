//
//  Astronaut.swift
//  IISLocation
//
//  Created by Taras Holets on 20/07/2018.
//  Copyright © 2018 Taras Holets. All rights reserved.
//

class Astronaut: Decodable {
    
    let craft: String
    let name: String
    
    init(craft: String, name: String) {
        self.craft = craft
        self.name = name
    }
}

class AstronautsData: Decodable {
    
    let message: String
    let people: [Astronaut]
    let number: Int
    
    init(message: String, people: [Astronaut], number: Int) {
        self.message = message
        self.people = people
        self.number = number
    }
    
    var astronautsNames: String {
        return people.map({$0.name}).joined(separator: ", ")
    }
}
