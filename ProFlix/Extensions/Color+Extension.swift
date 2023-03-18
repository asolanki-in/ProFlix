//
//  Color+Extension.swift
//  ProFlix
//
//  Created by Anil Solanki on 03/03/23.
//

import SwiftUI

extension Color {

	static let swatch1 = Color(hex: "#521254") ?? .pink
	static let swatch2 = Color(hex: "#502760") ?? .pink
	static let swatch3 = Color(hex: "#E9A178") ?? .pink
	static let swatch4 = Color(hex: "#34c3eb") ?? .pink
	static let swatch5 = Color(hex: "#3cb38d") ?? .pink
	static let swatch6 = Color(hex: "#E96479") ?? .pink
	static let swatch7 = Color(hex: "#ecb22c") ?? .pink
	static let swatch8 = Color(hex: "#b5afaf") ?? .pink
	static let swatch9 = Color(hex: "#d6d4d3") ?? .pink
	static let swatch10 = Color(hex: "#f4eee2") ?? .pink

#if os(tvOS)
	static let systemGrayColor = Color(.systemGray)
	static let systemGrayColor2 = Color(.systemGray)
	static let systemGrayColor3 = Color(.systemGray)
	static let systemGrayColor4 = Color(.systemGray)
	static let systemGrayColor5 = Color(.systemGray)
	static let systemGrayColor6 = Color(.systemGray)
#else
	static let systemGrayColor = Color(.systemGray)
	static let systemGrayColor2 = Color(.systemGray2)
	static let systemGrayColor3 = Color(.systemGray3)
	static let systemGrayColor4 = Color(.systemGray4)
	static let systemGrayColor5 = Color(.systemGray5)
	static let systemGrayColor6 = Color(.systemGray6)
#endif


}




extension Color {

	init?(hex: String) {
		var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
		hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

		var rgb: UInt64 = 0

		var r: CGFloat = 0.0
		var g: CGFloat = 0.0
		var b: CGFloat = 0.0
		var a: CGFloat = 1.0

		let length = hexSanitized.count

		guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }

		if length == 6 {
			r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
			g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
			b = CGFloat(rgb & 0x0000FF) / 255.0

		} else if length == 8 {
			r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
			g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
			b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
			a = CGFloat(rgb & 0x000000FF) / 255.0

		} else {
			return nil
		}

		self.init(red: r, green: g, blue: b, opacity: a)
	}

	func toHex() -> String? {
		let uic = UIColor(self)
		guard let components = uic.cgColor.components, components.count >= 3 else {
			return nil
		}
		let r = Float(components[0])
		let g = Float(components[1])
		let b = Float(components[2])
		var a = Float(1.0)

		if components.count >= 4 {
			a = Float(components[3])
		}

		if a != Float(1.0) {
			return String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
		} else {
			return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
		}
	}
}


struct ProColor : Identifiable, Hashable {
	var id = UUID()
	var color: Color

	static let allColor : [ProColor] = [ProColor(color: .swatch1),
										ProColor(color: .swatch2),
										ProColor(color: .swatch3),
										ProColor(color: .swatch4),
										ProColor(color: .swatch5),
										ProColor(color: .swatch6),
										ProColor(color: .swatch7),
										ProColor(color: .swatch8),
										ProColor(color: .swatch9),
										ProColor(color: .swatch10)]
}

