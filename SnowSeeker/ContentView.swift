//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Сергей Цайбель on 27.05.2022.
//

import SwiftUI

extension View {
	@ViewBuilder func phoneOnlyNavigationView() -> some View {
		if UIDevice.current.userInterfaceIdiom == .phone {
			self.navigationViewStyle(.stack)
		} else {
			self
		}
	}
}

struct ContentView: View {
	let resorts: [Resort] = Bundle.main.decode("resorts.json")
	
	@State private var searchedText = ""
	
	var filteredResorts: [Resort] {
		if searchedText.isEmpty {
			return resorts
		} else {
			return resorts.filter { $0.name.localizedCaseInsensitiveContains(searchedText) }
		}
	}
	
    var body: some View {
		NavigationView {
			List(filteredResorts) { resort in
				NavigationLink {
					ResortView(resort: resort)
				} label: {
					Image(resort.country)
						.resizable()
						.scaledToFill()
						.frame(width: 50, height: 30)
						.clipShape(RoundedRectangle(cornerRadius: 5))
						.overlay(RoundedRectangle(cornerRadius: 5)
							.stroke(lineWidth: 1)
						)
					VStack(alignment: .leading) {
						Text(resort.name)
							.font(.headline)
						Text("\(resort.runs) runs")
						foregroundColor(.secondary)
					}
				}
				.dynamicTypeSize(...DynamicTypeSize.xxxLarge)

			}
			.navigationTitle("Resorts")
			
			WelcomeView()
		}
		.searchable(text: $searchedText, prompt: "Search for resorts")
		.phoneOnlyNavigationView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
