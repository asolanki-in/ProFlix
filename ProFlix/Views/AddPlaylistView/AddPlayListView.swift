//
//  AddPlayListView.swift
//  ProFlix
//
//  Created by Anil Solanki on 05/03/23.
//

import SwiftUI

struct AddPlayListView: View {

	@Environment(\.presentationMode) private var presentationMode
	@EnvironmentObject var coreData : CoreDataEnvironmentObject
	@StateObject var observed = Observed()

	var body: some View {
		NavigationStack {
			Group {
				switch observed.state {
				case .form:
					AddPlayListFormView(observed: observed)
						.toolbar {
							toolbarItemTrailing
							toolbarItemLeading
						}
				case .fetch:
					AddingItemsView(url: observed.playlistUrl, name: observed.playlistName, color: observed.color)
				case .fetchfail:
					AddPlayListFailView(reason: "Something went wrong while downloading playlist.")
						.toolbar {
							toolbarItemLeading
						}
				case .fetchdone:
					AddPlayListSuccessView(url: observed.playlistUrl, name: observed.playlistName, color: observed.color)
						.toolbar {
							toolbarItemLeading
						}
				}
			}
			.navigationTitle("Add Playlist")
			.navigationBarTitleDisplayMode(.inline)
			.toolbarBackground(.visible, for: .navigationBar)
			.interactiveDismissDisabled(true)
		}
	}

	var toolbarItemTrailing : ToolbarItem<(), Button<some View>> {
		ToolbarItem(placement: .navigationBarTrailing) {
			Button(action: add) {
				Text("Done")
					.fontWeight(.bold)
					.disabled(observed.playlistName.isEmpty || observed.playlistUrl.isEmpty)
			}
		}
	}

	var toolbarItemLeading : ToolbarItem<(), Button<some View>> {
		ToolbarItem(placement: .navigationBarLeading) {
			Button {
				self.presentationMode.wrappedValue.dismiss()
			} label: {
				Text("Dismiss")
			}
		}
	}

	private func add() {
		if self.observed.formValidation() {
			self.observed.state = .fetch
			Task {
				let success = await self.coreData.createSaveLibrary(self.observed.playlistName,
																	self.observed.playlistUrl,
																	color: self.observed.color)
				await MainActor.run {
					if success {
						self.observed.state = .fetchdone
					} else {
						self.observed.state = .fetchfail
					}
				}
			}
		}
	}

}

struct AddPlayListView_Previews: PreviewProvider {

	static var previews: some View {
		Text("")
			.sheet(isPresented: .constant(true)) {
				AddPlayListView()
			}
	}
}
