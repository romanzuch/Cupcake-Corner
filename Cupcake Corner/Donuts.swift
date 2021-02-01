//
//  Donuts.swift
//  Cupcake Corner
//
//  Created by Roman on 01.02.21.
//

import Foundation

struct Donuts {
    
    struct Donut: Codable, Identifiable {
        var id: String
        var name: String
        var pricing: Int
        var type: String
        var description: String
    }
    
    let donuts: [Donut]
}
