//
//  AboutViewController.swift
//  ShootFromTheHip
//
//  Created by Ayi Padilla on 10/14/20.
//

import UIKit

class AboutViewController: UITableViewController {
  static let storyboardIdentifier = "AboutViewController"
  static let navControllerStoryboardIdentifier = "AboutNavigationController"
  
  @IBOutlet private weak var closeButton: UIBarButtonItem!

  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  private func setupView() {
    closeButton.target = self
    closeButton.action = #selector(closeView(_:))
    
    navigationController?.navigationBar.shadowImage = UIImage()
    tableView.tableFooterView = UIView()
  }
  
  @objc private func closeView(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
}
