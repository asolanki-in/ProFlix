//
//  QuickPlayStream+CoreDataProperties.swift
//  ProFlix
//
//  Created by Anil Solanki on 07/03/23.
//
//

import Foundation
import CoreData


extension QuickPlayStream {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuickPlayStream> {
        return NSFetchRequest<QuickPlayStream>(entityName: "QuickPlayStream")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var url: String?

	var wrappedName : String {
		return name ?? "Other"
	}

	var wrappedURL : URL {
		return URL(string: url ?? "")!
	}
}

extension QuickPlayStream : Identifiable {

}
