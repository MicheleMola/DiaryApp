//
//  EntriesDataSource.swift
//  DiaryApp
//
//  Created by Michele Mola on 08/09/2018.
//  Copyright © 2018 Michele Mola. All rights reserved.
//

import UIKit
import CoreData

class EntriesDataSource: NSObject, UITableViewDataSource {
  private let tableView: UITableView
  private let fetchedResultsController: EntriesFetchedResultsController
  
  init(fetchRequest: NSFetchRequest<Entry>, managedObjectContext context: NSManagedObjectContext, tableView: UITableView) {
    self.tableView = tableView
    self.fetchedResultsController = EntriesFetchedResultsController(request: fetchRequest, context: context)
    super.init()
    
    self.fetchedResultsController.delegate = self
  }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return fetchedResultsController.sections?[section].numberOfObjects ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let entryCell = tableView.dequeueReusableCell(withIdentifier: EntryCell.reuseIdentifier, for: indexPath) as! EntryCell
    
    let entry = fetchedResultsController.object(at: indexPath)
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .long
    let stringDate: String = dateFormatter.string(from: entry.creationDate as Date)
    
    entryCell.dateLabel.text = stringDate
      
    entryCell.contentTextView.text = entry.contentText
    
    
    //let photo = fetchedResultsController.object(at: indexPath)
    //photoCell.photoView.image = photo.image
    
    return entryCell
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    let date = Date()
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    formatter.locale = Locale(identifier: "en_US")
    let formattedDate = formatter.string(from: date)
    
    return formattedDate
  }
  
  
}

extension EntriesDataSource: NSFetchedResultsControllerDelegate {
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.reloadData()
  }
}

extension EntriesDataSource {
  var photos: [Entry] {
    guard let objects = fetchedResultsController.sections?.first?.objects as? [Entry] else {
      return []
    }
    
    return objects
  }
}


