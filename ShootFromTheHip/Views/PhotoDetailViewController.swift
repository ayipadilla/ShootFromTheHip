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
  @IBOutlet private weak var shareButton: UIButton!
  var shareImage: UIImage?

  let viewModel: PhotoDetailViewModel = PhotoDetailViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    setupPhotoImageView()
  }
  
  private func setupView() {
    closeButton.addTarget(self, action: #selector(closeButtonTapped(_:)), for: .touchUpInside)
    shareButton.addTarget(self, action: #selector(shareButtonTapped(_:)), for: .touchUpInside)
  }
  
  private func setupPhotoImageView() {
    guard let photoImageUrl = viewModel.photoImageURL,
          let heightWidthRatio = viewModel.heightWidthRatio else { return }
    photoImageHeight.constant = UIScreen.main.bounds.width * CGFloat(heightWidthRatio)
    photoImageView.sd_setImage(with: photoImageUrl) { [weak self] (image, error, cacheType, url) in
      guard let self = self else { return }
      self.shareImage = image
    }
    view.layoutIfNeeded()
  }
  
  @objc private func closeButtonTapped(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  @objc private func shareButtonTapped(_ sender: Any) {
    var items: [Any] = []
    if let photoImage = shareImage {
      items.append(photoImage)
    } else if let photoImageURL = viewModel.photoImageURL {
      items.append(photoImageURL)
    }
    guard !items.isEmpty else { return }
    let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
    present(activityViewController, animated: true)
  }
}

