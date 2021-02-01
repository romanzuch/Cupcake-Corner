//
//  CartElement.swift
//  Cupcake Corner
//
//  Created by Roman on 01.02.21.
//

import Foundation

struct CartElement: Codable, Identifiable {
    
    var id = UUID()
    var name: String
    var amount: Int
    var price: Double
    
}
