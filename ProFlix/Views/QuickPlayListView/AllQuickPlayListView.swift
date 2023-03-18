//
//  AllQuickPlayListView.swift
//  ProFlix
//
//  Created by Anil Solanki on 07/03/23.
//

import SwiftUI

struct AllQuickPlayListView: View {

	@EnvironmentObject var coreData : CoreDataEnvironmentObject
	@EnvironmentObject var router : NavRouter

	@State var items : [QuickPlayStream] = []

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
				ForEach(coreData.allQuickList) { stream in
					NavigationLink(value: NavDestination.VideoPlayerView(stream.wrappedURL, stream.wrappedName)) {
						SmallCardView(stream.wrappedName, color: .gray)
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
		.navigationTitle("QuickPlay")
		.navigationBarTitleDisplayMode(.inline)
		.task {
			await MainActor.run {
				self.items = coreData.allQuickList
			}
		}
	}

	private func actionDelete() {

	}
}

struct AllQuickPlayListView_Previews: PreviewProvider {
    static var previews: some View {
        AllQuickPlayListView()
    }
}
