//
//  ViewController.swift
//  ShootFromTheHip
//
//  Created by Ayi Padilla on 10/13/20.
//

import UIKit

class PhotosStreamViewController: UIViewController {
  
  private let viewModel: PhotosStreamViewModel = PhotosStreamViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Shoot from the Hip"
    
    viewModel.fetchPhotos()
  }  
}

