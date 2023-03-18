//
//  StreamAttribute+CoreDataProperties.swift
//  ProFlix
//
//  Created by Anil Solanki on 26/02/23.
//
//

import Foundation
import CoreData


extension StreamAttribute {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StreamAttribute> {
        return NSFetchRequest<StreamAttribute>(entityName: "StreamAttribute")
    }

    @NSManaged public var id: String?
    @NSManaged public var groupTitle: String?
    @NSManaged public var logo: String?
    @NSManaged public var toStream: Stream?

}

extension StreamAttribute : Identifiable {

}
