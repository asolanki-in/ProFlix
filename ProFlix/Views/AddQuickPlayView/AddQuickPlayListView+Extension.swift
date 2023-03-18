//
//  AddQuickPlayListView+Extension.swift
//  ProFlix
//
//  Created by Anil Solanki on 07/03/23.
//

import Foundation
import SwiftUI

extension AddQuickPlayListView {

	final class Observed : ObservableObject {

		enum AddQuickPlayListState {
			case form, adding, done, fail
		}

		@Published var state: AddQuickPlayListState = .form

		@Published var name : String = ""
		@Published var url : String = ""
		@Published var validationMessage = ""
		var color: Color = .gray

		public func formValidation() -> Bool {
			guard let url = URL(string: url) else {
				self.validationMessage = "Name & URL cannot be empty"
				return false
			}

			let canopen = UIApplication.shared.canOpenURL(url)
			if canopen == false {
				self.validationMessage = "Please enter a valid URL"
				return false
			}
			self.validationMessage = ""
			return true
		}
	}

}
