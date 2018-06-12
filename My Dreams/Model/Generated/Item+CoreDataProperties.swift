//
//  Item+CoreDataProperties.swift
//  My Dreams
//
//  Created by Mobile Jakarta Team on 03/06/18.
//  Copyright © 2018 moonshadow. All rights reserved.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var title: String?
    @NSManaged public var price: Double
    @NSManaged public var details: String?
    @NSManaged public var created: NSDate?
    @NSManaged public var toImage: Image?
    @NSManaged public var toStore: Store?
    @NSManaged public var toItemType: ItemType?

}
