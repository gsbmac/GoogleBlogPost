//
//  Post+CoreDataProperties.swift
//  MiniBlog
//
//  Created by Mac on 10/6/15.
//  Copyright © 2015 Seer Technologies, Inc. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Post {

    @NSManaged var content: String?
    @NSManaged var title: String?
    @NSManaged var date: NSDate?
    @NSManaged var post_author: Author?

}
