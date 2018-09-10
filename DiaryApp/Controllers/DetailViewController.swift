//
//  DetailViewController.swift
//  DiaryApp
//
//  Created by Michele Mola on 07/09/2018.
//  Copyright © 2018 Michele Mola. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {
  
  var context: NSManagedObjectContext?
  
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var contentTextView: UITextView!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var emoticonImageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    contentTextView.delegate = self
    contentTextView.text = "What happened today?"
    contentTextView.textColor = UIColor.lightGray
    
    configureDate()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func configureView() {
    
  }
  
  var detailItem: Entry? {
    didSet {
      // Update the view.
      configureView()
    }
  }
    
  func configureDate() {
    let date = Date()
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .none
    formatter.locale = Locale(identifier: "en_US")
    let formattedDate = formatter.string(from: date)
    
    dateLabel.text = formattedDate
  }
  
  @IBAction func savePressed(_ sender: UIBarButtonItem) {
    guard let context = context, let contentText = contentTextView.text else { return }
    
    let _ = Entry.with(nil, locationName: nil, content: contentText, emoticon: nil, in: context)
    
    do {
      try context.save()
      print("save")
    } catch let error as NSError {
      print("Could not save. \(error), \(error.userInfo)")
    }

  }
  
  @IBAction func changeEmoticon(_ sender: UIButton) {
    switch sender.tag {
    case 0:
      emoticonImageView.image = #imageLiteral(resourceName: "icn_bad")
    case 1:
      emoticonImageView.image = #imageLiteral(resourceName: "icn_average")
    case 2:
      emoticonImageView.image = #imageLiteral(resourceName: "icn_happy")
    default:
      return
    }
  }
  
}

extension DetailViewController: UITextViewDelegate {
  func textViewDidBeginEditing(_ textView: UITextView) {
    if textView.textColor == UIColor.lightGray {
      textView.text = nil
      textView.textColor = UIColor.black
    }
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    if textView.text.isEmpty {
      textView.text = "What happened today?"
      textView.textColor = UIColor.lightGray
    }
  }
}

