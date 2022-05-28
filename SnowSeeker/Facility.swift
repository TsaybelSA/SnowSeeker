//
//  Facility.swift
//  SnowSeeker
//
//  Created by Сергей Цайбель on 28.05.2022.
//

import Foundation

struct Facility: Identifiable {
	let id = UUID()
	let name: String
	
	private let icons = [
		"Family": "👨‍👩‍👧‍👦",
		"Cross-country": "🏔",
		"Accommodation": "🏬",
		"Eco-friendly": "☘️",
		"Beginners": "👶"
	]
	
	private let descriptions = [
		"Family": "This resort is popular for families.",
		"Cross-country": "This resort is for experienced riders who wants to check himself.",
		"Accommodation": "This resort have all for comportable living.",
		"Eco-friendly": "This resort has won award for environmental friendliness.",
		"Beginners": "This resort has ski-school for beginners."
	]
	
	var icon: String {
		if let iconName = icons[name] {
			return iconName
		} else {
			fatalError("Can`t find icon for facility \(name)")
		}
	}
	
	var description: String {
		if let facilityDescription = descriptions[name] {
			return facilityDescription
		} else {
			fatalError("Can`t find description for facility \(name)")
		}
	}
}
