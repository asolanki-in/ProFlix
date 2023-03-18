//
//  CoreDataEnvironmentObject.swift
//  ProFlix
//
//  Created by Anil Solanki on 05/03/23.
//

import Foundation
import SwiftUI


final class CoreDataEnvironmentObject : ObservableObject {

	let cd = CoreDataManager.shared

	@Published var fetching = true
	@Published var allPlaylist : [StreamLibrary] = []
	@Published var allQuickList : [QuickPlayStream] = []

	public func fetchAll() {
		self.fetching = true
		Task {
			let plyst = await fetchAllPlaylist()
			let quicklst = await fetchAllQuicklist()
			await self.completedFetchPlaylist(list: plyst, quick: quicklst)
		}
	}

	@MainActor
	private func completedFetchPlaylist(list: [StreamLibrary]?, quick: [QuickPlayStream]?) {
		if let list {
			self.allPlaylist = list
		}

		if let quick {
			self.allQuickList = quick
		}

		self.fetching = false
	}

	private func fetchAllPlaylist() async -> [StreamLibrary]? {
		do {
			let request = StreamLibrary.fetchRequest()
			request.sortDescriptors = []
			return try cd.viewContext.fetch(request)
		} catch {
			print(error.localizedDescription)
		}
		return nil
	}

	public func createSaveLibrary(_ name: String, _ url: String, color: Color) async -> Bool {
		if let playlist = cd.saveStreamLibrary(name, url, color: color) {
			if let m3ulist = try? M3UWrapper().parse(m3uStr: playlist.url ?? "") {
				for media in m3ulist.medias {
					let _ = cd.saveStream(media: media, library: playlist)
				}

				await MainActor.run {
					self.allPlaylist.append(playlist)
				}
				
				return true
			}
		}
		return false
	}

	private func fetchAllQuicklist() async -> [QuickPlayStream]? {
		do {
			let request = QuickPlayStream.fetchRequest()
			request.sortDescriptors = []
			return try cd.viewContext.fetch(request)
		} catch {
			print(error.localizedDescription)
		}
		return nil
	}


	public func createQuickPlay(_ name: String, _ url: String) async -> Bool {
		if let stream = cd.saveQuickPlayStream(name, url) {
			await MainActor.run {
				self.allQuickList.append(stream)
			}
			return true
		}
		return false
	}
}
