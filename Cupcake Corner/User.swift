//
//  User.swift
//  Cupcake Corner
//
//  Created by Roman on 01.02.21.
//

import Foundation

class User: ObservableObject, Codable {
    @Published var name = "Paul Hudson"
    
    enum CodingKeys: CodingKey {
        case name
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }
}
