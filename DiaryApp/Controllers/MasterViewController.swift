//
//  MasterViewController.swift
//  DiaryApp
//
//  Created by Michele Mola on 07/09/2018.
//  Copyright © 2018 Michele Mola. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController {
  
  var detailViewController: DetailViewController? = nil
  var managedObjectContext: NSManagedObjectContext? = nil
  
  @IBOutlet weak var addButton: UIBarButtonItem!
  @IBOutlet weak var currentDateLabel: UILabel!
  
  lazy var dataSource: EntriesDataSource = {
    let request: NSFetchRequest<Entry> = Entry.fetchRequest()
    guard let managedContext = managedObjectContext else { fatalError("ManagedContext is null") }
    return EntriesDataSource(fetchRequest: request, managedObjectContext: managedContext, tableView: self.tableView)
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureView()
    
    if let split = splitViewController {
      let controllers = split.viewControllers
      detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
    }
  }
  
  func configureView() {
    addButton.image = #imageLiteral(resourceName: "Icn_write")
    
    tableView.dataSource = dataSource
    
    let date = Date()
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .none
    formatter.locale = Locale(identifier: "en_US")
    let formattedDate = formatter.string(from: date)
    
    currentDateLabel.text = formattedDate
  }
  
  override func viewWillAppear(_ animated: Bool) {
    clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
    super.viewWillAppear(animated)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Segues
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showDetail" {
      if let indexPath = tableView.indexPathForSelectedRow {
        //        let object = fetchedResultsController.object(at: indexPath)
        //            let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
        //            controller.detailItem = object
        //            controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        //            controller.navigationItem.leftItemsSupplementBackButton = true
      }
    } else if segue.identifier == "addEntry" {
      let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
      controller.context = managedObjectContext
    }
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 220
  }
  
}



