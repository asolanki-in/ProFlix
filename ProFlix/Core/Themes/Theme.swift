//
//  Theme.swift
//  ProFlix
//
//  Created by Anil Solanki on 19/02/23.
//

import SwiftUI

protocol Theme {
	var primaryBgColor : Color { set get }
	var secondaryBgColor : Color { set get }


	//MARK: Text/Label Clors
	var primaryTextColor : Color { set get }
	var secondaryTextColor : Color { set get }
}

struct DarkNight: Theme {
	var primaryBgColor = Color(red: 27.0/255.0, green: 34.0/255.0, blue: 45.0/255.0)
	var secondaryBgColor = Color(red: 36.0/255.0, green: 48.0/255.0, blue: 62.0/255.0)

	var primaryTextColor = Color.white
	var secondaryTextColor = Color.gray
}

struct Dark: Theme {
	var primaryBgColor = Color.black
	var secondaryBgColor = Color(red: 28.0/255.0, green: 28.0/255.0, blue: 30.0/255.0)

	var primaryTextColor = Color.white
	var secondaryTextColor = Color.gray
}

