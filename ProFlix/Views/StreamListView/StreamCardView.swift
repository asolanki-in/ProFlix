//
//  StreamCardView.swift
//  ProFlix
//
//  Created by Anil Solanki on 05/03/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct StreamCardView: View {

	let title: String
	let subtitle: String
	let url : String?
	let icon : String?

	var body: some View {
		HStack {
			WebImage(url: URL(string: icon ?? ""))
				.resizable()
				.placeholder { Color(.systemGray5) }
				.transition(.fade(duration: 0.3))
				.scaledToFit()
				.frame(width: 80, height: 80, alignment: .center)
				.padding(.horizontal)

			VStack(alignment: .leading) {
				Text(title).font(.title3)
				Text(url ?? "-").foregroundColor(.secondary)
			}

			Spacer()

			Text(subtitle)
				.font(.footnote)
				.foregroundColor(.secondary)
				.padding(.trailing, 10)

		}
		.padding(.vertical, 5)
	}
}

struct StreamCardView_Previews: PreviewProvider {
	static var previews: some View {
		//https://i.imgur.com/bcHP3Vg.png
		//https://i.imgur.com/XgejLKw.png
		List {
			StreamCardView(title: "aaa", subtitle: "aaaa", url: "nil", icon: nil)
			StreamCardView(title: "aaa", subtitle: "aaaa", url: "nil", icon: "https://i.imgur.com/XgejLKw.png")

		}

	}
}
