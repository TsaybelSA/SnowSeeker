//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Сергей Цайбель on 28.05.2022.
//

import Foundation

class Favorites: ObservableObject {
	
	var resorts: Set<String>
	
	func add(_ resort: Resort) {
		objectWillChange.send()
		resorts.insert(resort.id)
		save()
	}
	
	func remove(_ resort: Resort) {
		objectWillChange.send()
		resorts.remove(resort.id)
		save()
	}
	
	func contains(_ resort: Resort) -> Bool {
		return resorts.contains(resort.id)
	}
	
	let userDefaultKey = "Favorites"
	
	func save() {
		guard let encoded = try? JSONEncoder().encode(resorts) else {
			print("Failed to encode data.")
			return
		}
			UserDefaults.standard.set(encoded, forKey: userDefaultKey)
	}
	
	init() {
		if let data = UserDefaults.standard.data(forKey: userDefaultKey) {
			if let decoded = try? JSONDecoder().decode(Set<String>.self, from: data) {
				resorts = decoded
				return
			}
		}
		resorts = []
	}
}
