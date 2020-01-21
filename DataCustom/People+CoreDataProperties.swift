//
//  Student+CoreDataProperties.swift
//  DataCustom
//
//  Created by MacStudent on 2020-01-15.
//  Copyright © 2020 MacStudent. All rights reserved.
//
//

import Foundation
import CoreData


extension People {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<People> {
        return NSFetchRequest<People>(entityName: "People")
    }

    @NSManaged public var name: String?
    @NSManaged public var tution: Double
    @NSManaged public var age: Int32
    @NSManaged public var startDate: Date?

}
