//
//  RootView.swift
//  ProFlix
//
//  Created by Anil Solanki on 04/03/23.
//

import SwiftUI

struct RootView: View {

	let colors1 = [Color(hex: "#74ebd5") ?? .pink,  Color(hex: "#ACB6E5") ?? .purple]
	let colors2 = [Color(hex: "#ff9966") ?? .pink,  Color(hex: "#ff5e62") ?? .purple]
	let colors3 = [Color(hex: "#ffc3a0") ?? .pink,  Color(hex: "#FFAFBD") ?? .purple]

	let closeArr = 0...4

	let rows = [
		GridItem(.flexible())
	]

	@State var activeSheetView : ActiveSheetView?
	@StateObject var router = NavRouter()

	@EnvironmentObject var coreData : CoreDataEnvironmentObject

	var body: some View {
		NavigationStack(path: $router.navPath) {
			List {
				Grid(horizontalSpacing: 15) {
					GridRow {
						CardView("Recent", systemName: "clock.arrow.circlepath", colors: colors1)
						CardView("Favourites", systemName: "heart", colors: colors2)
						CardView("Protected Streams", systemName: "lock", colors: colors3)
					}
				}
				.listRowSeparator(.hidden)

				Section(header: header("Quick Play", subtitle: "All the direct stream using url",action: {
					self.router.appendPath(NavDestination.AllQuickListView)
				})) {
					ScrollView(.horizontal, showsIndicators: false) {
						LazyHGrid(rows: rows, alignment: .center, spacing: 15) {
							Button(action: showAddQuickPlayView) {
								CardAddView()
							}
							.buttonStyle(ScaledEffect())

							if coreData.allQuickList.count > 5 {
								ForEach(closeArr, id: \.self) { index in
									let stream = coreData.allQuickList[index]
									Button(action: { actionQuickPlay(of: stream) }) {
										SmallCardView(stream.wrappedName, color: .gray)
									}
									.buttonStyle(ScaledEffect())
								}
							} else {
								ForEach(coreData.allQuickList) { stream in
									Button(action: { actionQuickPlay(of: stream) }) {
										SmallCardView(stream.wrappedName, color: .gray)
									}
									.buttonStyle(ScaledEffect())
								}
							}
						}
					}
				}
				.listRowSeparator(.hidden)

				Section(header: header("Playlist", subtitle: "All the streams you imported from url", action: {
					self.router.appendPath(NavDestination.AllPlaylistView)
				})) {
					ScrollView(.horizontal, showsIndicators: false) {
						LazyHGrid(rows: rows, alignment: .center, spacing: 15) {
							Button(action: showAddPlayListView) {
								CardAddView()
							}
							.buttonStyle(ScaledEffect())

							if coreData.allPlaylist.count > 5 {
								ForEach(closeArr, id: \.self) { index in
									let lib = coreData.allPlaylist[index]
									Button(action: {
										actionShowStream(of: lib)
									}) {
										SmallCardView(lib.wrappedName, color: Color(hex: lib.wrappedColor) ?? .pink)
									}
									.buttonStyle(ScaledEffect())
								}
							} else {
								ForEach(coreData.allPlaylist) { streamLib in
									Button(action: {
										actionShowStream(of: streamLib)
									}) {
										SmallCardView(streamLib.wrappedName, color: Color(hex: streamLib.wrappedColor) ?? .pink)
									}
									.buttonStyle(ScaledEffect())

								}
							}
						}
					}
				}
				.listRowSeparator(.hidden)
			}
			.environmentObject(router)
			.navigationTitle("ProFlix")
			.listStyle(PlainListStyle())
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					HStack(spacing: 16) {
						Button(action: actionSeeAll) {
							Image(systemName: "questionmark.app.dashed").imageScale(.large)
						}
					}
				}
			}
			.sheet(item: $activeSheetView) { sheet in
				switch sheet {
				case .AddPlayListSheet:
					AddPlayListView()
				case .AddQuickPlaySheet:
					AddQuickPlayListView()
				}
			}
			.navigationDestination(for: NavDestination.self) { destination in
				switch destination {
				case .AllPlaylistView:
					AllPlaylistView()
				case .AllQuickListView:
					AllQuickPlayListView()
				case .StreamListView(let library):
					StreamListView(library: library)
				case .VideoPlayerView(let url, let title):
					VideoPlayerView(url: url, title: title)
				}
			}
		}
	}

	private func header(_ title: String, subtitle: String, action: @escaping () -> Void) -> AnyView {
		AnyView(HStack(alignment: .top) {
			VStack(alignment: .leading) {
				Text(title)
					.font(.title2)
					.fontWeight(.bold)
					.foregroundColor(.primary)
				Text(subtitle)
					.foregroundColor(.secondary)
					.font(.body)
					.fontWeight(.light)

			}
			Spacer()
			Button(action: action) {
				Text("See All")
			}
		})
	}

	private func showAddPlayListView() {
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
			self.activeSheetView = .AddPlayListSheet
		}
	}

	private func showAddQuickPlayView() {
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
			self.activeSheetView = .AddQuickPlaySheet
		}
	}

	private func actionShowStream(of library: StreamLibrary) {
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
			self.router.appendPath(NavDestination.StreamListView(library))
		}
	}

	private func actionQuickPlay(of stream: QuickPlayStream) {
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
			if let url = URL(string: stream.url ?? "") {
				self.router.appendPath(NavDestination.VideoPlayerView(url, stream.wrappedName))
			}
		}
	}

	private func actionSeeAll() {

	}

	private func actionAddLibrary() {

	}
}

struct RootView_Previews: PreviewProvider {
	static var previews: some View {
		RootView()
	}
}


enum ActiveSheetView: Identifiable {
	case AddPlayListSheet
	case AddQuickPlaySheet

	var id: Int {
		hashValue
	}
}


enum NavDestination : Hashable {
	case AllPlaylistView
	case AllQuickListView
	case StreamListView(StreamLibrary)
	case VideoPlayerView(URL, String)
}
