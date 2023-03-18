//
//  StreamLibrary+CoreDataProperties.swift
//  ProFlix
//
//  Created by Anil Solanki on 03/03/23.
//
//

import Foundation
import CoreData


extension StreamLibrary {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StreamLibrary> {
        return NSFetchRequest<StreamLibrary>(entityName: "StreamLibrary")
    }

    @NSManaged public var color: String?
    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var url: String?
    @NSManaged public var stream: NSSet?

	var wrappedName : String {
		return title ?? "Other"
	}

	var wrappedColor : String {
		return color ?? "#ff0000"
	}

	var allStreams : [Stream] {
		guard let set = stream as? Set<Stream> else {
			return []
		}
		return set.sorted { $0.wrappedName < $1.wrappedName }
	}

}

// MARK: Generated accessors for stream
extension StreamLibrary {

    @objc(addStreamObject:)
    @NSManaged public func addToStream(_ value: Stream)

    @objc(removeStreamObject:)
    @NSManaged public func removeFromStream(_ value: Stream)

    @objc(addStream:)
    @NSManaged public func addToStream(_ values: NSSet)

    @objc(removeStream:)
    @NSManaged public func removeFromStream(_ values: NSSet)

}

extension StreamLibrary : Identifiable {

}
