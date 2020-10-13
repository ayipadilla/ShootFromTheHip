//
//  AboutViewController.swift
//  ShootFromTheHip
//
//  Created by Ayi Padilla on 10/14/20.
//

import UIKit

class AboutViewController: UIViewController {
  static let storyboardIdentifier = "AboutViewController"
  
  @IBOutlet private weak var closeButton: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    closeButton.addTarget(self, action: #selector(closeView(_:)), for: .touchUpInside)
  }
  
  @objc private func closeView(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
}
