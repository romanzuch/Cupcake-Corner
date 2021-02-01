//
//  Order.swift
//  Cupcake Corner
//
//  Created by Roman on 01.02.21.
//

import Foundation

class Order: ObservableObject {

    let donuts: [Donut] = Bundle.main.decode("donuts.json")
    @Published var cart = [CartElement]()
    @Published var cartTotal: Double = 0.0
    @Published var totalAmount: Int = 0
    
    @Published var classic = 0
    @Published var special = 0
    @Published var classicQuantity = 1
    @Published var specialQuantity = 1
    
    @Published var specialRequestEnabled = false
    
    func addNewCartItem(_ element: CartElement) {
        cart.append(element)
    }
    
    func calculateTotal(_ price: Double) {
        cartTotal += price
    }
    
    func calculateItems(_ amount: Int) {
        totalAmount += amount
    }
    
    func getTotal() -> Double {
        switch totalAmount {
        case 4:
            return 10.0
        case 6:
            return 15.0
        case 12:
            return 26.0
        default:
            return cartTotal
        }
    }
}
