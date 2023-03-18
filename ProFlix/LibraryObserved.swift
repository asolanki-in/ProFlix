//
//  LibraryObserved.swift
//  ProFlix
//
//  Created by Anil Solanki on 26/02/23.
//

import Foundation
import CoreData
import M3UKit

class LibraryObserved : NSObject, ObservableObject {

	let cd = CoreDataManager.shared

	let url = "https://raw.githubusercontent.com/hmripon66/indianiptv/main/India.m3u8"

	var libraries : [StreamLibrary] = []

	public func getLibraries() async -> [StreamLibrary]? {
		do {
			let request = StreamLibrary.fetchRequest()
			request.sortDescriptors = []
			return try cd.viewContext.fetch(request)
		} catch {
			print(error.localizedDescription)
		}
		return nil
	}

	public func downloadSaveStreams(from library: StreamLibrary) async {
		if let playlist = try? M3UWrapper().parse(m3uStr: library.url ?? url) {
			for media in playlist.medias {
				let _ = cd.saveStream(media: media, library: library)
			}
		}
	}


	func getAllStreams() async throws -> [Stream] {
		let request = Stream.fetchRequest()
		request.sortDescriptors = []
		return try cd.viewContext.fetch(request)
	}

	func saveLibrary() {
		let _ = cd.saveStreamLibrary("AllChannel", url, color: .teal)
	}

	func getLibrary() async throws -> [StreamLibrary] {
		let request = StreamLibrary.fetchRequest()
		request.sortDescriptors = []
		return try cd.viewContext.fetch(request)
	}

}

extension LibraryObserved : NSFetchedResultsControllerDelegate {
	func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {

	}
}

struct M3UWrapper {
	public func parse(m3uStr: String) throws -> Playlist? {
		let parser = PlaylistParser()
		if let url = URL(string: m3uStr) {
			return try parser.parse(url)
		}
		return nil
	}
}
