//
//  ButtonStyles.swift
//  ProFlix
//
//  Created by Anil Solanki on 05/03/23.
//

import SwiftUI

struct ScaledEffect: ButtonStyle {
	func makeBody(configuration: Self.Configuration) -> some View {
		configuration.label.scaleEffect(configuration.isPressed ? 0.9 : 1)
	}
}
