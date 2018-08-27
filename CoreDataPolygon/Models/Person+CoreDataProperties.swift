//
//  Person+CoreDataProperties.swift
//  CoreDataPolygon
//
//  Created by Mariusz Sut on 27.08.2018.
//  Copyright © 2018 Mariusz Sut. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var createDate: NSDate?
    @NSManaged public var home: Home?

}
