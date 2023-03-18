//
//  AllPlaylistView.swift
//  ProFlix
//
//  Created by Anil Solanki on 05/03/23.
//

import SwiftUI

struct AllPlaylistView: View {

	@EnvironmentObject var coreData : CoreDataEnvironmentObject
	@EnvironmentObject var router : NavRouter

	@State var items : [StreamLibrary] = []

	let columns = [
		GridItem(.flexible()),
		GridItem(.flexible()),
		GridItem(.flexible()),
		GridItem(.flexible()),
		GridItem(.flexible())
	]

	var body: some View {
		ScrollView(.vertical, showsIndicators: false) {
			LazyVGrid(columns: columns, alignment: .center, spacing: 30) {
				ForEach(coreData.allPlaylist) { streamLib in
					NavigationLink(value: NavDestination.StreamListView(streamLib)) {
						SmallCardView(streamLib.wrappedName, color: Color(hex: streamLib.wrappedColor) ?? .pink)
							.contextMenu {
								Button {
									print("Change country setting")
								} label: {
									Label("Copy URL", systemImage: "doc.on.doc")
								}

								Button(role: .destructive, action: actionDelete){
									Label("Delete", systemImage: "trash")
								}
							}
					}
				}
			}
			.padding()
		}
		.navigationTitle("Playlist")
		.navigationBarTitleDisplayMode(.inline)
		.task {
			await MainActor.run {
				self.items = coreData.allPlaylist
			}
		}
	}

	private func actionDelete() {

	}
}

struct AllPlaylistView_Previews: PreviewProvider {
	static var previews: some View {
		AllPlaylistView()
	}
}
