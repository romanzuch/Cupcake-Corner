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
        TabView {
            DonutsView(order: order)
                .tabItem {
                    Image(systemName: "info.circle")
                    Text("Donuts")
                }
            CartView(order: order)
                .tabItem {
                    Image(systemName: "cart")
                    Text("Warenkorb")
                }
        }
    }
}
