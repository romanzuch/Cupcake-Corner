//
//  DonutsView.swift
//  Cupcake Corner
//
//  Created by Roman on 01.02.21.
//

import SwiftUI

struct DonutsView: View {
    var order: Order
    
    var body: some View {
        NavigationView {
            List(order.donuts) { donut in
                NavigationLink(destination: DetailView(title: donut.name, image: donut.id, description: donut.description, pricing: donut.pricing, order: order)) {
                    HStack {
                        VStack(alignment: .leading, spacing: nil) {
                            Text("\(donut.name)")
                                .font(.headline)
                            Text("\(donut.type)".capitalized)
                        }
                        Spacer()
                        Image(donut.id)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 44, height: 44)
                    }
                }
            }
            .navigationBarTitle("Brammibals", displayMode: .inline)
        }
    }
}
