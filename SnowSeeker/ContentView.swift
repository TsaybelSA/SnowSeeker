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
	
	enum SortTypes: String, CaseIterable, Identifiable {
		case original, name, country, favorites
		var id: Self { self }
	}
	
	let resorts: [Resort] = Bundle.main.decode("resorts.json")
	
	@StateObject var favorites = Favorites()
	
	@State private var searchedText = ""
	
	@State private var sortType: SortTypes = .name
	@State private var showingConfirmation = false
	
    var body: some View {
		NavigationView {
			List(filteredResorts) { resort in
				NavigationLink {
					ResortView(resort: resort)
				} label: {
					HStack {
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
								.foregroundColor(.secondary)
						}
						
						if favorites.contains(resort) {
							Spacer()
							Image(systemName: "heart.fill")
								.accessibilityLabel("This is the favorite resort")
								.foregroundColor(.red)
						}
					}
				}
//				.dynamicTypeSize(...DynamicTypeSize.xxxLarge)

			}
			.navigationTitle("Resorts")
			.confirmationDialog("Sorted by:", isPresented: $showingConfirmation) {
				Label("Circle", systemImage: "circle")
			}
			.toolbar {
				ToolbarItemGroup(placement: .navigationBarTrailing) {
					HStack {
						Text("Sort by:")
						Picker("", selection: $sortType) {
							ForEach(SortTypes.allCases) { sortType in
								Text(sortType.rawValue.capitalized)
							}
						}
					}
				}
			}
			WelcomeView()
		}
		.searchable(text: $searchedText, prompt: "Search for resorts")
		.environmentObject(favorites)
    }
	
	func sortResortsByFavoritesList(first: Resort, second: Resort) -> Bool {
		if favorites.contains(first) {
			return true
		} else {
			return false
		}
	}
	
	var sortedResorts: [Resort] {
		switch sortType {
			case .original:
				return resorts
			case .name:
				return resorts.sorted(by: { $0.name < $1.name })
			case .country:
				return resorts.sorted(by: { $0.country < $1.country })
			case .favorites:
				return resorts.sorted(by: sortResortsByFavoritesList)
		}
	}
	
	var filteredResorts: [Resort] {
		if searchedText.isEmpty {
			return sortedResorts
		} else {
			return sortedResorts.filter { $0.name.localizedCaseInsensitiveContains(searchedText) }
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
