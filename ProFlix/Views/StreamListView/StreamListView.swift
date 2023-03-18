//
//  StreamListView.swift
//  ProFlix
//
//  Created by Anil Solanki on 05/03/23.
//

import SwiftUI

struct StreamListView: View {

	@State var didAppear = false
	@State var searchText = ""
	let library: StreamLibrary

	@State var allStreams : [Stream] = []

    var body: some View {
		VStack {
			List(allStreams) { stream in
				NavigationLink(value: NavDestination.VideoPlayerView(stream.wrappedURL, stream.wrappedName)) {
					StreamCardView(title: stream.wrappedName,
								   subtitle: stream.attributes?.groupTitle ?? "other",
								   url: stream.url, icon: stream.attributes?.logo)
				}
			}
		}
		.searchable(text: $searchText, prompt: "Name or Category")
		.onChange(of: searchText) { _ in
			filterStreams(text: searchText)
		}
		.navigationTitle(library.wrappedName)
		.navigationBarTitleDisplayMode(.inline)
		.onAppear {
			if self.didAppear == false {
				self.allStreams = library.allStreams
			}
			self.didAppear = true
		}
    }

	private func filterStreams(text: String) {
		if text.isEmpty == false {
			Task.detached {
				if let filtered = await quickFilter(text: text) {
					await MainActor.run {
						self.allStreams = filtered
					}
				}
			}
		} else {
			self.allStreams = library.allStreams
		}
	}

	private func quickFilter(text: String) async -> [Stream]? {
		return self.library.allStreams.filter({ $0.wrappedName.localizedCaseInsensitiveContains(text) })
	}

}

struct StreamListView_Previews: PreviewProvider {
    static var previews: some View {
        StreamListView(library: StreamLibrary())
    }
}
