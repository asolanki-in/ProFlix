//
//  Text+Modifier.swift
//  ProFlix
//
//  Created by Anil Solanki on 20/02/23.
//

import SwiftUI

extension View {
	func text(font: Font, weight: Font.Weight = .regular, color: Color) -> some View {
		modifier(PFText(font: font, color: color, weight: weight))
	}
}
