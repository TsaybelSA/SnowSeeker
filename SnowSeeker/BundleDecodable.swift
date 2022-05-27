//
//  BundleDecodable.swift
//  SnowSeeker
//
//  Created by Сергей Цайбель on 27.05.2022.
//

import Foundation

extension Bundle {
	func decode<T: Decodable>(_ file: String) -> T {
		guard let url = self.url(forResource: file, withExtension: .none) else {
			fatalError("Failed to locate \(file) in Bundle")
		}
		
		guard let data = try? Data(contentsOf: url) else {
			fatalError("Failed to load data from \(url)")
		}
		
		guard let decoded = try? JSONDecoder().decode(T.self, from: data) else {
			fatalError("Failed to decode \(data)")
		}
		return decoded
	}
}
