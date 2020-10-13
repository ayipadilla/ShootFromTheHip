//
//  PhotosStreamViewModel.swift
//  ShootFromTheHip
//
//  Created by Ayi Padilla on 10/14/20.
//

import Foundation
import Combine

class PhotosStreamViewModel {
  private let photosFetcher: PhotosFetchable
  
  init(photosFetcher: PhotosFetchable = PhotosFetcher()) {
    self.photosFetcher = photosFetcher
  }
  
  func fetchPhotos() {
    photosFetcher.fetchPhotos { (photosResponse, error) in
      guard error == nil, let _ = photosResponse else {
        return
      }
      
      // TODO:
      // Publish photos
    }
  }
}
