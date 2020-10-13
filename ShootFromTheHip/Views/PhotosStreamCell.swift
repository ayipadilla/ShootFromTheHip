//
//  PhotosStreamCell.swift
//  ShootFromTheHip
//
//  Created by Ayi Padilla on 10/14/20.
//

import UIKit

struct PhotoStreamCellData {
  let heading: String
}

class PhotosStreamCell: UITableViewCell {
  static let cellIdentifier = "PhotosStreamCell"
  
  @IBOutlet private weak var headingLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  func configure(_ cellData: PhotoStreamCellData) {
    headingLabel.text = cellData.heading
  }
  
}
