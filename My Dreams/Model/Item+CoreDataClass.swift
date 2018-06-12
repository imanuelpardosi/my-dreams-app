//
//  Item+CoreDataClass.swift
//  My Dreams
//
//  Created by Mobile Jakarta Team on 03/06/18.
//  Copyright © 2018 moonshadow. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        self.created = NSDate()
    }
}
