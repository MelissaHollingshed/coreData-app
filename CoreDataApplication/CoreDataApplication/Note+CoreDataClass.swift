//
//  Note+CoreDataClass.swift
//  CoreDataApplication
//
//  Created by Melissa Hollingshed on 12/12/18.
//  Copyright © 2018 Melissa Hollingshed. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Note)
public class Note: NSManagedObject {
    
    var modificationDate: Date {
        get {
            return rawModificationDate as Date
        }
        set {
            rawModificationDate = newValue as NSDate
        }
    }
    
    convenience init?(title: String, content: String?, modificationDate: Date) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        let context = appDelegate.persistentContainer.viewContext
        self.init(entity: Note.entity(), insertInto: context)
        self.title = title
        self.content = content
        self.modificationDate = modificationDate
    }

}
