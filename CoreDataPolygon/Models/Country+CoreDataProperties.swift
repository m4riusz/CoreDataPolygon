//
//  Country+CoreDataProperties.swift
//  CoreDataPolygon
//
//  Created by Mariusz Sut on 30.08.2018.
//  Copyright © 2018 Mariusz Sut. All rights reserved.
//
//

import Foundation
import CoreData


extension Country {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Country> {
        return NSFetchRequest<Country>(entityName: "Country")
    }

    @NSManaged public var name: String?
    @NSManaged public var code: String?
    @NSManaged public var home: NSSet?

}

// MARK: Generated accessors for home
extension Country {

    @objc(addHomeObject:)
    @NSManaged public func addToHome(_ value: Home)

    @objc(removeHomeObject:)
    @NSManaged public func removeFromHome(_ value: Home)

    @objc(addHome:)
    @NSManaged public func addToHome(_ values: NSSet)

    @objc(removeHome:)
    @NSManaged public func removeFromHome(_ values: NSSet)

}
