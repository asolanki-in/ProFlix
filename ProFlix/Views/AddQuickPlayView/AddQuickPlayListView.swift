//
//  AddQuickPlayListView.swift
//  ProFlix
//
//  Created by Anil Solanki on 07/03/23.
//

import SwiftUI

struct AddQuickPlayListView: View {

	@Environment(\.presentationMode) private var presentationMode
	@EnvironmentObject var coreData : CoreDataEnvironmentObject
	@StateObject var observed = Observed()

	var body: some View {
		NavigationStack {
			Group {
				switch observed.state {
				case .form:
					AddQuickPlayFormView(observed: observed)
						.toolbar {
							toolbarItemTrailing
							toolbarItemLeading
						}
				case .adding:
					AddingItemsView(url: observed.url, name: observed.name, color: observed.color)
				case .fail:
					AddPlayListFailView(reason: "Something went wrong while adding url.")
						.toolbar {
							toolbarItemLeading
						}
				case .done:
					AddPlayListSuccessView(url: observed.url, name: observed.name, color: observed.color)
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
					.disabled(observed.name.isEmpty || observed.url.isEmpty)
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
			self.observed.state = .adding
			Task {
				let success = await self.coreData.createQuickPlay(observed.name, observed.url)
				await MainActor.run {
					if success {
						self.observed.state = .done
					} else {
						self.observed.state = .fail
					}
				}
			}
		}
	}

}

struct AddQuickPlayListView_Previews: PreviewProvider {

	static var previews: some View {
		Text("")
			.sheet(isPresented: .constant(true)) {
				AddQuickPlayListView()
			}
	}
}
