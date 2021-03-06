//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Сергей Цайбель on 27.05.2022.
//

import SwiftUI

struct ResortView: View {
	@Environment(\.horizontalSizeClass) var horizontalSizeClass
	@Environment(\.dynamicTypeSize) var dynamicTypeSize
	@EnvironmentObject var favorites: Favorites
	
	let resort: Resort
	
	@State private var selectedFacility: Facility?
	@State private var isShowingAlert = false
	
    var body: some View {
		ScrollView {
			VStack(alignment: .leading, spacing: 0) {
				ZStack {
					Image(decorative: resort.id)
						.resizable()
						.scaledToFit()
					HStack {
						Spacer()
						VStack {
							Spacer()
							Text(resort.imageCredit)
								.font(.caption)
								.padding(7)
								.foregroundColor(.white)
								.background(.black.opacity(0.6))
								.clipShape(Capsule())
								.padding(5)
						}
					}
				}
				HStack {
					if horizontalSizeClass == .compact && dynamicTypeSize > .xLarge {
						VStack(spacing: 10) { ResortDetailsView(resort: resort) }
						VStack(spacing: 10) { SkiDetailsView(resort: resort) }
					} else {
						ResortDetailsView(resort: resort)
						SkiDetailsView(resort: resort)
					}
				}
				.padding(.vertical)
				.background(Color.primary.opacity(0.1))
				
				Group {
					Text(resort.description)
						.padding(.vertical)
					Text("Facilities:")
						.font(.title3.bold())
					HStack(spacing: 15) {
						ForEach(resort.facilitiesList) { facility in
							Button {
								selectedFacility = facility
								isShowingAlert = true
							} label: {
								Text(facility.icon)
									.font(.largeTitle)
							}
						}
					}
					.padding(.vertical)
				}
				.padding(.horizontal)
				
				Button(favorites.contains(resort) ? "Remove from favorites" : "Add to favorites") {
					if favorites.contains(resort) {
						favorites.remove(resort)
					} else {
						favorites.add(resort)
					}
				}
				.buttonStyle(.borderedProminent)
				.padding()
			}
		}
		.navigationTitle("\(resort.name), \(resort.country)")
		.navigationBarTitleDisplayMode(.inline)
		.alert(selectedFacility?.name ?? "More Information", isPresented: $isShowingAlert, presenting: selectedFacility) { _ in
		} message: { facility in
			Text(facility.description)
		}
	}
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
		ResortView(resort: Resort.example)
			.environmentObject(Favorites())
    }
}
