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

  private let viewModel: PhotosStreamViewModel = PhotosStreamViewModel()
  private var subscriptions: Set<AnyCancellable> = []

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Shoot from the Hip"
    
    setupViews()
    setupBindings()
    viewModel.fetchPhotos()
  }
  
  private func setupViews() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UINib(nibName: PhotosStreamCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: PhotosStreamCell.cellIdentifier)
    tableView.reloadData()
  }
  
  private func setupBindings() {
    viewModel.$photoStream.sink { [weak self] (_) in
      guard let self = self else { return }
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }.store(in: &subscriptions)
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
    return 44.0
  }
}

extension PhotosStreamViewController: UITableViewDelegate {
  
}
