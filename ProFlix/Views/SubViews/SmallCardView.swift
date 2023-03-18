//
//  SmallCardView.swift
//  ProFlix
//
//  Created by Anil Solanki on 04/03/23.
//

import SwiftUI

struct SmallCardView: View {

	let gradient : LinearGradient
	let title: String

	init(_ title: String, color: Color) {
		if title.isEmpty {
			self.title = "A"
		} else {
			self.title = title
		}
		self.gradient = LinearGradient(colors: [color, color.opacity(0.8)], startPoint: .topLeading, endPoint: .bottom)
	}
	var body: some View {
		VStack(spacing: 5) {
			Image(systemName: "\(title.prefix(1).lowercased()).circle.fill")
				.symbolRenderingMode(.hierarchical)
				.font(.system(size: 40))
				.foregroundColor(.white)
			Text(title).foregroundColor(.white)
		}
		.frame(minWidth: 200,maxWidth: 200, minHeight: 125, maxHeight: 125)
		.background(gradient)
		.shadow(color: Color.systemGrayColor5, radius: 2, x: 1, y: 1)
		.cornerRadius(20)

	}
}

struct SmallCardView_Previews: PreviewProvider {
	static var previews: some View {
		SmallCardView("AnilSolanki", color: .pink)
	}
}
