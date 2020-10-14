//
//  PhotoDetailViewController.swift
//  ShootFromTheHip
//
//  Created by Ayi Padilla on 10/14/20.
//

import UIKit
import SDWebImage

class PhotoDetailViewController: UIViewController {
  @IBOutlet private weak var photoImageView: UIImageView!
  @IBOutlet private weak var photoImageHeight: NSLayoutConstraint!

  let viewModel: PhotoDetailViewModel = PhotoDetailViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  func setupView() {
    guard let photoImageUrl = viewModel.photoImageURL,
          let heightWidthRatio = viewModel.heightWidthRatio else { return }
    photoImageHeight.constant = UIScreen.main.bounds.width * CGFloat(heightWidthRatio)
    photoImageView.sd_setImage(with: photoImageUrl, completed: nil)
    view.layoutIfNeeded()
  }
}

