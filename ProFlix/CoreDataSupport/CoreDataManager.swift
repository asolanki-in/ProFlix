//
//  CoreDataManager.swift
//  ProFlix
//
//  Created by Anil Solanki on 26/02/23.
//

import Foundation
import CoreData
import M3UKit
import SwiftUI

final class CoreDataManager {
	static let shared = CoreDataManager()
	private let container: NSPersistentCloudKitContainer

	private init() {
		container = NSPersistentCloudKitContainer(name: "ProFlix")
		container.loadPersistentStores(completionHandler: { (storeDescription, error) in
			if let error = error as NSError? {
				print("Unresolved error \(error), \(error.userInfo)")
			}
		})
		container.viewContext.automaticallyMergesChangesFromParent = true
		container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
	}

	var viewContext: NSManagedObjectContext {
		container.viewContext
	}
}


extension CoreDataManager {
	public func saveStream(media: Playlist.Media, library: StreamLibrary) -> Bool {
		return self.viewContext.performAndWait {
			let stream = Stream(context: self.viewContext)
			stream.id = UUID()
			stream.name = media.name
			stream.kind = media.kind.rawValue
			stream.url = media.url.absoluteString

			let attributes = StreamAttribute(context: self.viewContext)
			attributes.id = media.attributes.id
			attributes.groupTitle = media.attributes.groupTitle
			attributes.logo = media.attributes.logo

			attributes.toStream = stream
			stream.attributes = attributes
			stream.addToLibrary(library)

			do {
				try self.viewContext.save()
				return true
			} catch {
				print(error)
				self.viewContext.delete(stream)
			}

			return false

		}
	}

	public func saveStreamLibrary(_ title: String, _ url: String, color: Color) -> StreamLibrary? {
		return self.viewContext.performAndWait {
			let library = StreamLibrary(context: self.viewContext)
			library.id = UUID()
			library.title = title
			library.url = url
			let strColor = color.toHex()
			library.color = strColor
			do {
				try self.viewContext.save()
				return library
			} catch {
				print(error)
				self.viewContext.delete(library)
			}
			return nil
		}

	}

	public func saveQuickPlayStream(_ name: String, _ url: String) -> QuickPlayStream? {
		return self.viewContext.performAndWait {
			let stream = QuickPlayStream(context: self.viewContext)
			stream.id = UUID()
			stream.name = name
			stream.url = url
			do {
				try self.viewContext.save()
				return stream
			} catch {
				print(error)
				self.viewContext.delete(stream)
			}
			return nil
		}
	}

	public func deleteStreamLibrary(library: StreamLibrary) -> Bool {
		do {
			self.viewContext.delete(library)
			try self.viewContext.save()
			return true
		} catch {
			print(error)
		}

		return false
	}

}
