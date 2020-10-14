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

  var previewImage: UIImage?
  var fullImage: UIImage?

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
    guard let previewImageURL = viewModel.previewImageURL,
          let fullImageURL = viewModel.photoImageURL,
          let heightWidthRatio = viewModel.heightWidthRatio
    else {
      return
    }
    
    let maxHeight = UIScreen.main.bounds.height * 0.75
    let scaledHeight = UIScreen.main.bounds.width * CGFloat(heightWidthRatio)
    photoImageHeight.constant = min(maxHeight, scaledHeight)
    view.layoutIfNeeded()

    let manager = SDWebImageManager.shared
    let options = SDWebImageOptions(rawValue: 0)
    manager.loadImage(with: previewImageURL, options: options, progress: nil) { [weak self] (image, data, error, cacheType, finished, url) in
      guard let self = self, finished else { return }
      self.previewImage = image
      if self.fullImage == nil {
        self.photoImageView.image = image
      }
    }
    
    manager.loadImage(with: fullImageURL, options: options, progress: nil) { [weak self] (image, data, error, cacheType, finished, url) in
      guard let self = self, finished else { return }
      self.fullImage = image
      self.photoImageView.image = image
    }
  }
  
  @objc private func closeButtonTapped(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  @objc private func shareButtonTapped(_ sender: Any) {
    var items: [Any] = []
    if let shareFullImage = fullImage {
      items.append(shareFullImage)
    } else if let sharePreviewImage = previewImage {
      items.append(sharePreviewImage)
    } else if let photoImageURL = viewModel.photoImageURL {
      items.append(photoImageURL)
    }

    guard !items.isEmpty else { return }
    let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
    present(activityViewController, animated: true)
  }
}

