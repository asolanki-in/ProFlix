//
//  AddPlayListFormView.swift
//  ProFlix
//
//  Created by Anil Solanki on 05/03/23.
//

import SwiftUI

struct AddPlayListFormView: View {

	@ObservedObject var observed : AddPlayListView.Observed

    var body: some View {
		Form {
			Section(footer: Text(observed.validationMessage).foregroundColor(.red)) {
				VStack(spacing: 20) {
					SmallCardView(observed.playlistName, color: observed.color)
					TextField("Enter name", text: $observed.playlistName)
						.padding(8)
						.background(Color.systemGrayColor6)
						.cornerRadius(6)
						.textContentType(.none)
						.multilineTextAlignment(.center)

					TextField("URL", text: $observed.playlistUrl)
						.padding(8)
						.background(Color.systemGrayColor6)
						.cornerRadius(6)
						.textContentType(.URL)
						.multilineTextAlignment(.center)
						.keyboardType(.URL)
				}
				.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
				.padding(.top)
				.padding(.bottom, 8)
			}

			Section {
				ScrollView(.horizontal, showsIndicators: false) {
					Grid {
						GridRow {
							ForEach(ProColor.allColor) { pro in
								Button {
									self.observed.selected = pro.id
									self.observed.color = pro.color
								} label: {
									if let selected = observed.selected, selected == pro.id {
										ColorCircle(color: pro.color, selected: true)
									} else {
										ColorCircle(color: pro.color, selected: false)
									}
								}
							}
						}
					}
				}
			}

		}
    }

	@ViewBuilder
	private func ColorCircle(color: Color, selected: Bool) -> some View {
		color
			.clipShape(Circle())
			.padding(3)
			.overlay(Circle().stroke(Color.gray, lineWidth: selected ? 3 : 0))
			.frame(width: 80, height: 80)
			.padding(3)
	}
}
