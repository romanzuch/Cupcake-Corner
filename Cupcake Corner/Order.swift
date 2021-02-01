//
//  Order.swift
//  Cupcake Corner
//
//  Created by Roman on 01.02.21.
//

import Foundation

class Order: ObservableObject {
//    static let classics = ["Rum Raisin Walnut",
//                           "Lemon Poppyseed",
//                           "White Choc & Strawberries",
//                           "Cinnamon Sugar",
//                           "Pink Sprinkles",
//                           "Caramel Hazelnut"]
//    static let specials = ["Choch Caramel Marshmallow",
//                           "Sachertorte",
//                           "Orange Almond Fudge",
//                           "Chocolate Peanut Fudge",
//                           "Chocolate Hazelnut Filled",
//                           "Cookie Dough",
//                           "Boston Cream"]
    
    let donuts: [Donuts.Donut] = Bundle.main.decode("donuts.json")
    
    @Published var classic = 0
    @Published var special = 0
    @Published var classicQuantity = 1
    @Published var specialQuantity = 1
    
    @Published var specialRequestEnabled = false
    
}
