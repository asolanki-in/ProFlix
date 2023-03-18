//
//  ThemeManager.swift
//  ProFlix
//
//  Created by Anil Solanki on 19/02/23.
//

import Foundation
import SwiftUI

final class ThemeManager : ObservableObject {

	public func change(to theme: Theme) {
		self.theme = theme
	}

	@Published private(set) var theme: Theme = Dark()

	var primaryText : Color {
		return theme.primaryTextColor
	}

	var secondaryText : Color {
		return theme.secondaryTextColor
	}

	var primaryBackground : Color {
		return theme.primaryBgColor
	}

	var secondaryBackground : Color {
		return theme.secondaryBgColor
	}

}
