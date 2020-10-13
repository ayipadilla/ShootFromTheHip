//
//  ViewController.swift
//  ShootFromTheHip
//
//  Created by Ayi Padilla on 10/13/20.
//

import UIKit

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Shoot from the Hip"
    
    PhotosFetcher().fetchPhotos { (photos, error) in
      print("Fetched photos")
    }
  }
  
  
}

