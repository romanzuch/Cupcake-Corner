//
//  DetailView.swift
//  Cupcake Corner
//
//  Created by Roman on 01.02.21.
//

import SwiftUI

struct DetailView: View {
    var title: String
    var image: String
    var description: String
    var pricing: Double
    @ObservedObject var order: Order
    
    @State private var amountSelected: Bool = false
    @State private var numberOfDonuts: Int = 0
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 10) {
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geo.size.width, height: geo.size.height*0.4)
                Section {
                    Text("Bestellen")
                        .font(.headline)
                    Stepper(value: $numberOfDonuts, in: 0...10) {
                        if numberOfDonuts == 0 {
                            Text("Keine Donuts")
                        } else if numberOfDonuts == 1 {
                            Text("\(numberOfDonuts) Donut")
                        } else {
                            Text("\(numberOfDonuts) Donuts")
                        }
                    }
                    Button("Zum Warenkorb") {
                        let newCartPricing: Double = Double(numberOfDonuts) * pricing
                        let newCartElement: CartElement = CartElement(name: title, amount: numberOfDonuts, price: newCartPricing)
                        order.addNewCartItem(newCartElement)
                        order.calculateTotal(newCartPricing)
                        order.calculateItems(numberOfDonuts)
                    }
                    .disabled(numberOfDonuts == 0)
                }
                Section {
                    Text("Beschreibung")
                        .font(.headline)
                    Text(description)
                }
            }
        }
            .navigationBarTitle(title)
    }
}
