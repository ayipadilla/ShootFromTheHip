//
//  PhotoDetailViewModel.swift
//  ShootFromTheHip
//
//  Created by Ayi Padilla on 10/14/20.
//

import Foundation

class PhotoDetailViewModel {
  var previewImageURL: URL?
  var photoImageURL: URL?
  var heightWidthRatio: Double?
  var username: String?
  
  var title: String {
    guard let username = username else { return "" }
    return "Photo by \(username)"
  }
}
