//
//  PhotosStreamCell.swift
//  ShootFromTheHip
//
//  Created by Ayi Padilla on 10/14/20.
//

import UIKit
import SDWebImage

struct PhotoStreamCellData {
  let heading: String
  let imageURL: URL?
  let heightWidthRatio: Double
}

class PhotosStreamCell: UITableViewCell {
  static let cellIdentifier = "PhotosStreamCell"
  
  @IBOutlet private weak var headingLabel: UILabel!
  @IBOutlet private weak var photoImageView: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  func configure(_ cellData: PhotoStreamCellData) {
    headingLabel.text = cellData.heading
    photoImageView.sd_setImage(with: cellData.imageURL, completed: nil)
  }
  
}
