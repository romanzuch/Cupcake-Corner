//
//  ContentView.swift
//  Cupcake Corner
//
//  Created by Roman on 31.01.21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var order = Order()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Our classics", selection: $order.classic) {
                        ForEach(0..<Order.classics.count) {
                            Text(Order.classics[$0])
                        }
                    }
                    Stepper(value: $order.classicQuantity, in: 1...10) {
                        Text("Number of classics: \(order.classicQuantity)")
                    }
                }
                Section {
                    Picker("Our specials", selection: $order.special) {
                        ForEach(0..<Order.specials.count) {
                            Text(Order.specials[$0])
                        }
                    }
                    Stepper(value: $order.specialQuantity, in: 1...10) {
                        Text("Number of specials: \(order.specialQuantity)")
                    }
                }
            }
            .navigationBarTitle("Bramibals")
        }
    }
}
