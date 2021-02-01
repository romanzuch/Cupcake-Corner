//
//  User.swift
//  Cupcake Corner
//
//  Created by Roman on 01.02.21.
//

import Foundation

class User: ObservableObject, Codable {
    @Published var name = "Paul Hudson"
    
    // we need to tell Swift which properties should be loaded and saved
    enum CodingKeys: CodingKey {
        case name
    }
    
    // we need a function to encode the data with an instance of Encoder
    // it creates a container with the keys declared above
    // then it encodes all the values for each key
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
    
    // a custom initializer with an instance of Decoder
    // any sublcass of User needs its own initializer (due to required keyword)
    // the data is stored in a container where the keys match whatever cases we have declared above
    // values can be read directly from the container
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }
}
