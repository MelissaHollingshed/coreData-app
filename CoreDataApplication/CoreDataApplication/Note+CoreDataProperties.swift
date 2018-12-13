//
//  Note+CoreDataProperties.swift
//  CoreDataApplication
//
//  Created by Melissa Hollingshed on 12/12/18.
//  Copyright © 2018 Melissa Hollingshed. All rights reserved.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var content: String?
    @NSManaged public var rawModificationDate: NSDate
    @NSManaged public var title: String

}
