//
//  ViewController.swift
//  ShootFromTheHip
//
//  Created by Ayi Padilla on 10/13/20.
//

import UIKit
import Combine

class PhotosStreamViewController: UIViewController {
  
  @IBOutlet private weak var tableView: UITableView!
  @IBOutlet private weak var infoButton: UIBarButtonItem!
  private var refreshControl = UIRefreshControl()
  
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
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    // Fetch more items when last cell is about to be displayed
    let index = indexPath.row
    if index == viewModel.photoStream.count - 1 {
      viewModel.fetchPhotos()
    }
  }
}
