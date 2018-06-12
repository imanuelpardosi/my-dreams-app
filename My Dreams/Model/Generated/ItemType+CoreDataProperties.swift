//
//  ItemType+CoreDataProperties.swift
//  My Dreams
//
//  Created by Mobile Jakarta Team on 03/06/18.
//  Copyright © 2018 moonshadow. All rights reserved.
//
//

import Foundation
import CoreData


extension ItemType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemType> {
        return NSFetchRequest<ItemType>(entityName: "ItemType")
    }

    @NSManaged public var type: String?
    @NSManaged public var toItem: Item?

}
