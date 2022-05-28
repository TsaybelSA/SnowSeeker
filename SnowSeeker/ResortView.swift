//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Сергей Цайбель on 27.05.2022.
//

import SwiftUI

struct ResortView: View {
	let resort: Resort
    var body: some View {
		ScrollView {
			VStack(alignment: .leading, spacing: 0) {
				Image(decorative: resort.id)
					.resizable()
					.scaledToFit()
				
				HStack {
					ResortDetailsView(resort: resort)
					SkiDetailsView(resort: resort)
				}
				.padding(.vertical)
				.background(Color.primary.opacity(0.1))
				
				Group {
					Text(resort.description)
						.padding(.vertical)
					Text("Facilities")
						.font(.headline)
					Text(resort.facilities.joined(separator: ", "))
						.font(.body)
						.padding(.vertical)
				}
				.padding(.horizontal)
			}
		}
		.navigationTitle("\(resort.name), \(resort.country)")
		.navigationBarTitleDisplayMode(.inline)
	}
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
		ResortView(resort: Resort.example)
    }
}
