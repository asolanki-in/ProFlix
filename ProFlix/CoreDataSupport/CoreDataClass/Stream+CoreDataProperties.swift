//
//  Stream+CoreDataProperties.swift
//  ProFlix
//
//  Created by Anil Solanki on 03/03/23.
//
//

import Foundation
import CoreData


extension Stream {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Stream> {
        return NSFetchRequest<Stream>(entityName: "Stream")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var kind: String?
    @NSManaged public var name: String?
    @NSManaged public var url: String?
    @NSManaged public var attributes: StreamAttribute?
    @NSManaged public var library: NSSet?

	var wrappedName : String {
		return name ?? "Other"
	}

	var wrappedURL : URL {
		return URL(string: url ?? "")!
	}
}

// MARK: Generated accessors for library
extension Stream {

    @objc(addLibraryObject:)
    @NSManaged public func addToLibrary(_ value: StreamLibrary)

    @objc(removeLibraryObject:)
    @NSManaged public func removeFromLibrary(_ value: StreamLibrary)

    @objc(addLibrary:)
    @NSManaged public func addToLibrary(_ values: NSSet)

    @objc(removeLibrary:)
    @NSManaged public func removeFromLibrary(_ values: NSSet)

}

extension Stream : Identifiable {

}
