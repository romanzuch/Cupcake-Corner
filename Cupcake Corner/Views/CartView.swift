//
//  CartView.swift
//  Cupcake Corner
//
//  Created by Roman on 01.02.21.
//

import SwiftUI

struct CartView: View {
    @ObservedObject var order: Order
    
    func removeItem(at offsets: IndexSet) {
        order.cart.remove(atOffsets: offsets)
    }
    
    var body: some View {
        NavigationView {
            Form {
                ForEach(order.cart, id: \.id) { item in
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(item.name)
                                .font(.headline)
                            let cartItemAmount = item.amount
                            if cartItemAmount == 1 {
                                Text("\(cartItemAmount) Donut")
                                    .font(.subheadline)
                            } else {
                                Text("\(cartItemAmount) Donuts")
                                    .font(.subheadline)
                            }
                        }
                        Spacer()
                        let cartItemPrice = item.price
                        Text("\(cartItemPrice, specifier: "%.2f") €")
                            .font(.headline)
                    }
                }
                .onDelete(perform: removeItem)
                
                
                if let newCartAmount = order.cart.count {
                    if newCartAmount != 0 {
                        let cartTotal = order.getTotal()
                        Text("\(cartTotal, specifier: "%.2f") €")
                    }
                }
            }
                .navigationBarTitle("Brammibals", displayMode: .inline)
            .navigationBarItems(trailing: order.cart.count != 0 ? EditButton() : nil)
        }
    }
}
