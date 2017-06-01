//
//  News+CoreDataProperties.swift
//  
//
//  Created by Vishal Chaurasia on 7/17/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension News {

    @NSManaged var article_image: NSData?
    @NSManaged var article_link: String?
    @NSManaged var favourite: NSNumber?
    @NSManaged var read: NSNumber?
    @NSManaged var short_story: String?
    @NSManaged var title: String?
    @NSManaged var published_at: NSDate?

}
