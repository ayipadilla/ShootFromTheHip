//
//  AboutViewController.swift
//  ShootFromTheHip
//
//  Created by Ayi Padilla on 10/14/20.
//

import UIKit
import SafariServices

class AboutViewController: UITableViewController {
  static let storyboardIdentifier = "AboutViewController"
  static let navControllerStoryboardIdentifier = "AboutNavigationController"
  
  @IBOutlet private weak var closeButton: UIBarButtonItem!
  @IBOutlet private weak var appNameLabel: UILabel!
  @IBOutlet private weak var appVersionLabel: UILabel!
  @IBOutlet weak var creditsTextView: UITextView!
  
  private let viewModel = AboutViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    setupContent()
  }
  
  private func setupView() {
    creditsTextView.delegate = self

    closeButton.target = self
    closeButton.action = #selector(closeView(_:))
    
    navigationController?.navigationBar.shadowImage = UIImage()
    tableView.tableFooterView = UIView()
  }
  
  private func setupContent() {
    appNameLabel.text = viewModel.appDisplayName
    appVersionLabel.text = viewModel.appVersion
    creditsTextView.text = viewModel.iconCredits
  }
  
  @objc private func closeView(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  func showWebView(_ URL: URL) {
      let viewController = SFSafariViewController(url: URL)
      viewController.modalPresentationStyle = .popover
      present(viewController, animated: true, completion: nil)
  }
}

extension AboutViewController: UITextViewDelegate {
  func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
    showWebView(URL)
    return false
  }
}
