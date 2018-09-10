//
//  EntryCell.swift
//  DiaryApp
//
//  Created by Michele Mola on 08/09/2018.
//  Copyright © 2018 Michele Mola. All rights reserved.
//

import UIKit

class EntryCell: UITableViewCell {
  static let reuseIdentifier = String(describing: EntryCell.self)
  
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var contentTextView: UITextView!
  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var emoticonImage: UIImageView!
  @IBOutlet weak var photoImageView: UIImageView!
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}

