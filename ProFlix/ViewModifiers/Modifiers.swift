//
//  Text+Modifier.swift
//  ProFlix
//
//  Created by Anil Solanki on 20/02/23.
//

import SwiftUI

struct PFText: ViewModifier {
	let font: Font
	let color: Color
	let weight: Font.Weight

	func body(content: Content) -> some View {
		content
			.font(font)
			.foregroundColor(color)
			.fontWeight(weight)
	}
}
