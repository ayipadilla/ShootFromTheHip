//
//  PhotosStreamCell.swift
//  ShootFromTheHip
//
//  Created by Ayi Padilla on 10/14/20.
//

import UIKit
import SDWebImage

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
  
  func configure(_ cellData: PhotoStreamData) {
    headingLabel.text = cellData.username
    photoImageView.sd_setImage(with: cellData.previewImageURL, completed: nil)
  }
}
