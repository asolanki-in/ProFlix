//
//  CardView.swift
//  ProFlix
//
//  Created by Anil Solanki on 04/03/23.
//

import SwiftUI

struct CardView: View {

	let title: String
	let systemName: String
	let graident : LinearGradient

	init(_ title: String, systemName: String, colors: [Color]) {
		self.title = title
		self.systemName = systemName
		self.graident = LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottom)
	}

    var body: some View {
		VStack(alignment: .center, spacing: 5) {
			Image(systemName: systemName)
				.font(.system(size: 40))
				.fontWeight(.bold)
				.foregroundColor(.white)
			Text(title).foregroundColor(.white)
		}
		.frame(maxWidth: .infinity, minHeight: 165, maxHeight: 165)
		.background(graident)
		.cornerRadius(20)
		.shadow(color: Color.systemGrayColor5, radius: 2, x: 1, y: 1)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
		CardView("", systemName: "", colors: [.indigo])
    }
}
