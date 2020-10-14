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
  @IBOutlet private weak var closeButton: UIButton!

  let viewModel: PhotoDetailViewModel = PhotoDetailViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    setupPhotoImageView()
  }
  
  private func setupView() {
    closeButton.addTarget(self, action: #selector(closeButtonTapped(_:)), for: .touchUpInside)
  }
  
  private func setupPhotoImageView() {
    guard let photoImageUrl = viewModel.photoImageURL,
          let heightWidthRatio = viewModel.heightWidthRatio else { return }
    photoImageHeight.constant = UIScreen.main.bounds.width * CGFloat(heightWidthRatio)
    photoImageView.sd_setImage(with: photoImageUrl, completed: nil)
    view.layoutIfNeeded()
  }
  
  @objc private func closeButtonTapped(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
}

