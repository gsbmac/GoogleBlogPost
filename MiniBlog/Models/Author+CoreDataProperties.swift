//
//  Author+CoreDataProperties.swift
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

extension Author {

    @NSManaged var name: String?
    @NSManaged var author_post: NSSet?

}
