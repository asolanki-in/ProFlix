//
//  SmallRowView.swift
//  ProFlix
//
//  Created by Anil Solanki on 05/03/23.
//

import SwiftUI

struct SmallRowView: View {

	let gradient : LinearGradient
	let title: String

	init(_ title: String, color: Color) {
		self.title = title
		self.gradient = LinearGradient(colors: [color, color.opacity(0.8)], startPoint: .topLeading, endPoint: .bottom)
	}

	var body: some View {
		Image(systemName: "\(title.prefix(1).lowercased()).circle.fill")
			.symbolRenderingMode(.hierarchical)
			.font(.system(size: 40))
			.foregroundColor(.white)
			.frame(minWidth: 200,maxWidth: 200, minHeight: 125, maxHeight: 125)
			.background(gradient)
			.cornerRadius(20)
			.shadow(color: Color.systemGrayColor5, radius: 2, x: 1, y: 1)
	}
}
