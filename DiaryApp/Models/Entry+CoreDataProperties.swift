//
//  Entry+CoreDataProperties.swift
//  DiaryApp
//
//  Created by Michele Mola on 08/09/2018.
//  Copyright © 2018 Michele Mola. All rights reserved.
//
//

import UIKit
import CoreData
import Foundation

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
  @NSManaged public var contentText: String
  @NSManaged public var emoticonData: NSData?
}

extension Entry {
  static var entityName: String {
    return String(describing: Entry.self)
  }
  
  @nonobjc class func with(_ image: UIImage?, locationName: String?, content: String, emoticon: UIImage?, in context: NSManagedObjectContext) -> Entry {
    let entry = NSEntityDescription.insertNewObject(forEntityName: Entry.entityName, into: context) as! Entry
    
    entry.creationDate = Date() as NSDate
    
    if let image = image {
      entry.imageData = UIImageJPEGRepresentation(image, 1.0)! as NSData
    }
    
    entry.locationName = locationName
    entry.contentText = content
    
    if let emoticon = emoticon {
      entry.emoticonData = UIImageJPEGRepresentation(emoticon, 1.0)! as NSData
    }
    
    return entry
  }
}





