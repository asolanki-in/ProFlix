//
//  NavRouter.swift
//  ProFlix
//
//  Created by Anil Solanki on 05/03/23.
//

import Foundation
import SwiftUI

final class NavRouter : ObservableObject {
	@Published var navPath = NavigationPath()
	public func appendPath(_ destination: any Hashable) {
		self.navPath.append(destination)
	}
}
