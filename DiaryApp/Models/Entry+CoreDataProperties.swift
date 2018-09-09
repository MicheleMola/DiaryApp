//
//  Entry+CoreDataProperties.swift
//  DiaryApp
//
//  Created by Michele Mola on 08/09/2018.
//  Copyright © 2018 Michele Mola. All rights reserved.
//
//

import Foundation
import CoreData


extension Entry {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<Entry> {
    let request = NSFetchRequest<Entry>(entityName: "Entry")
    let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: true)
    request.sortDescriptors = [sortDescriptor]
    return request
  }
  
  @NSManaged public var creationDate: NSDate
  @NSManaged public var imageData: NSData?
  @NSManaged public var locationName: String?
  @NSManaged public var modificationDate: NSDate?
  @NSManaged public var text: String
}
