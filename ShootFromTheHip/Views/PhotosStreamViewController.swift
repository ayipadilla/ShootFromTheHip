//
//  ViewController.swift
//  ShootFromTheHip
//
//  Created by Ayi Padilla on 10/13/20.
//

import UIKit
import Combine

class PhotosStreamViewController: UITableViewController {
  
  @IBOutlet private weak var infoButton: UIBarButtonItem!
  
  private let viewModel: PhotosStreamViewModel = PhotosStreamViewModel()
  private var subscriptions: Set<AnyCancellable> = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Shoot from the Hip"
    
    setupViews()
    setupBindings()
    viewModel.refresh()
  }
  
  private func setupViews() {
    extendedLayoutIncludesOpaqueBars = true

    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UINib(nibName: PhotosStreamCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: PhotosStreamCell.cellIdentifier)
    
    refreshControl = UIRefreshControl()
    refreshControl?.addTarget(self, action: #selector(refreshPhotosStream(_:)), for: .valueChanged)
    tableView.refreshControl = refreshControl
    
    infoButton.target = self
    infoButton.action = #selector(showAboutView(_:))
  }
  
  private func setupBindings() {
    viewModel.$photoStream.sink { [weak self] (_) in
      guard let self = self else { return }
      DispatchQueue.main.async {
        self.refreshControl?.endRefreshing()
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
  
  private func showPhotoDetailView(at index: Int) {
    guard let photoDetailViewController = viewModel.photoDetailView(at: index) else { return }
    present(photoDetailViewController, animated: true, completion: nil)
  }

  // MARK: UITableViewDataSource
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.photoStream.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let index = indexPath.row
    guard index < viewModel.photoStream.count else { return 0 }
    let cellData = viewModel.photoStream[index]
    return tableView.frame.size.width * CGFloat(cellData.heightWidthRatio)
  }

  // MARK: UITableViewDelegate
  override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    // Fetch more items when last cell is about to be displayed
    let index = indexPath.row
    if index == viewModel.photoStream.count - 1 {
      viewModel.fetchPhotos()
    }
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    showPhotoDetailView(at: indexPath.row)
  }
}
