//
//  Home+CoreDataProperties.swift
//  CoreDataPolygon
//
//  Created by Mariusz Sut on 29.08.2018.
//  Copyright © 2018 Mariusz Sut. All rights reserved.
//
//

import Foundation
import CoreData


extension Home {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Home> {
        return NSFetchRequest<Home>(entityName: "Home")
    }

    @NSManaged public var city: String?
    @NSManaged public var postal: String?
    @NSManaged public var street: String?
    @NSManaged public var persons: NSSet?

}

// MARK: Generated accessors for persons
extension Home {

    @objc(addPersonsObject:)
    @NSManaged public func addToPersons(_ value: Person)

    @objc(removePersonsObject:)
    @NSManaged public func removeFromPersons(_ value: Person)

    @objc(addPersons:)
    @NSManaged public func addToPersons(_ values: NSSet)

    @objc(removePersons:)
    @NSManaged public func removeFromPersons(_ values: NSSet)

}
