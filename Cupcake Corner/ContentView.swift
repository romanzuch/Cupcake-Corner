//
//  ContentView.swift
//  Cupcake Corner
//
//  Created by Roman on 31.01.21.
//

import SwiftUI

struct ContentView: View {
    @State private var results = [Result]()
    
    func loadData() {
        print("Starting to load data...")
        guard let url = URL(string: "https://itunes.apple.com/search?term=ed+sheeran&entity=song") else {
            print("Invalid URL")
            return
        }
        print("Valid URL")
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                    // there is good data -> go back to main thread
                    print("Giving back to main thread.")
                    DispatchQueue.main.async {
                        self.results = decodedResponse.results
                    }
                    
                    return
                }
            }
            
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
    
    var body: some View {
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
        }
        .onAppear(perform: loadData)
    }
}
