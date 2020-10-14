//
//  ViewController.swift
//  ShootFromTheHip
//
//  Created by Ayi Padilla on 10/13/20.
//

import UIKit
import Combine
import QuickLook
import SDWebImage

class PhotosStreamViewController: UIViewController {
  
  @IBOutlet private weak var tableView: UITableView!
  @IBOutlet private weak var infoButton: UIBarButtonItem!
  private var refreshControl = UIRefreshControl()
  
  private var someURL: URL?
  
  
  private let viewModel: PhotosStreamViewModel = PhotosStreamViewModel()
  private var subscriptions: Set<AnyCancellable> = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Shoot from the Hip"
    
    setupViews()
    setupBindings()
    viewModel.refresh()
    
    let imageURL = URL(string:"https://avatars2.githubusercontent.com/u/1173738?s=460&u=d2d3a2ff0db5400f861d292a195b39ebc9fb5909&v=4")
    let manager = SDWebImageManager.shared
    manager.loadImage(with: imageURL,
                      options: .progressiveLoad) { (receivedSize, expectedSize, url) in
      
    } completed: { [weak self] (image, data, error, cacheType, finished, imageUrll) in
      guard let self = self else { return }
      if finished {
        let imagePath = SDImageCache.shared.cachePath(forKey: imageUrll?.absoluteString) ?? ""
        print(imagePath)
      }
      self.someURL = imageUrll
    }
    
  }
  
  private func setupViews() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UINib(nibName: PhotosStreamCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: PhotosStreamCell.cellIdentifier)
    
    refreshControl.addTarget(self, action: #selector(refreshPhotosStream(_:)), for: .valueChanged)
    tableView.addSubview(refreshControl)
    
    infoButton.target = self
    infoButton.action = #selector(showAboutView(_:))
  }
  
  private func setupBindings() {
    viewModel.$photoStream.sink { [weak self] (_) in
      guard let self = self else { return }
      DispatchQueue.main.async {
        if self.refreshControl.isRefreshing {
          self.refreshControl.endRefreshing()
        }
        self.tableView.reloadData()
      }
    }.store(in: &subscriptions)
  }
  
  @objc private func refreshPhotosStream(_ sender: Any) {
    viewModel.refresh()
  }
  
  // MARK: Navigation
  @objc private func showAboutView(_ sender: Any) {
    guard let aboutViewController = storyboard?.instantiateViewController(identifier: AboutViewController.storyboardIdentifier) else { return }
    present(aboutViewController, animated: true, completion: nil)
  }
  
  private func showPhoto(at index: Int) {
    
    let quickLookViewController = QLPreviewController()
    quickLookViewController.dataSource = self
    quickLookViewController.currentPreviewItemIndex = index
    present(quickLookViewController, animated: true)
  }
}

extension PhotosStreamViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.photoStream.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: PhotosStreamCell.cellIdentifier, for: indexPath)
    let index = indexPath.row
    guard index < viewModel.photoStream.count,
          let photosStreamCell = cell as? PhotosStreamCell
    else {
      return cell
    }
    let cellData = viewModel.photoStream[index]
    photosStreamCell.configure(cellData)
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let index = indexPath.row
    guard index < viewModel.photoStream.count else { return 0 }
    let cellData = viewModel.photoStream[index]
    return tableView.frame.size.width * CGFloat(cellData.heightWidthRatio)
  }
}

extension PhotosStreamViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    showPhoto(at: indexPath.row)
  }

  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    // Fetch more items when last cell is about to be displayed
    let index = indexPath.row
    if index == viewModel.photoStream.count - 1 {
      viewModel.fetchPhotos()
    }
  }
}

extension PhotosStreamViewController: QLPreviewControllerDataSource {
  func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
    1
    }

    func previewController(
      _ controller: QLPreviewController,
      previewItemAt index: Int
    ) -> QLPreviewItem {
      let cellData = viewModel.photoStream.first!
      let imagePath = SDImageCache.shared.cachePath(forKey: cellData.imageURL?.absoluteString) ?? ""
      let impt = SDImageCache.shared.cachePath(forKey: cellData.imageURL?.absoluteString)
      let imagePath2 = cellData.imageURL?.absoluteString ?? ""
//      let url = NSURL(string: imagePath ?? "")!
      
      let downloader = SDWebImageDownloader.shared
      downloader.downloadImage(with: cellData.imageURL) { (image, data, error, finished) in
        
      }
      
      let filePath = "file://\(imagePath)"
      let url = NSURL(string: filePath)
     return url!
    }
}
