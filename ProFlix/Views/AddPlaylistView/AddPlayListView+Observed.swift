//
//  AddPlayListView+Observed.swift
//  ProFlix
//
//  Created by Anil Solanki on 05/03/23.
//

import SwiftUI
import Foundation

extension AddPlayListView {

	final class Observed : ObservableObject {

		enum AddPlayListState {
			case form, fetch, fetchfail, fetchdone
		}
		
		@Published var state: AddPlayListState = .form

		@Published var playlistName : String = ""
		@Published var playlistUrl : String = ""
		@Published var selected : UUID?
		@Published var validationMessage = ""
		@Published var color: Color = .gray

		public func formValidation() -> Bool {
			guard let url = URL(string: playlistUrl) else {
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
