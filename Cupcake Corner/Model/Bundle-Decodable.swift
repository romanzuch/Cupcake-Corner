//
//  Bundle-Decodable.swift
//  Cupcake Corner
//
//  Created by Roman on 01.02.21.
//

import Foundation

extension Bundle {
    func decode(_ file: String) -> [Donut] {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in Bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from Bundle.")
        }

        let decoder = JSONDecoder()
        
        guard let loaded = try? decoder.decode([Donut].self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        
        return loaded
    }
}
