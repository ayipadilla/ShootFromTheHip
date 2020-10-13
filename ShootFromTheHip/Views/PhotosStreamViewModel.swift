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
  
  @Published var photoStream: [PhotoStreamCellData] = []
  
  init(photosFetcher: PhotosFetchable = PhotosFetcher()) {
    self.photosFetcher = photosFetcher
  }
  
  func fetchPhotos() {
    photosFetcher.fetchPhotos { [weak self] (photosResponse, error) in
      guard let self = self, error == nil,
            let photos = photosResponse
      else { return }
      
      let photosData = photos.map { (photo) in
        return PhotoStreamCellData(
          heading: photo.id
        )
      }
      guard !photosData.isEmpty else { return }
      self.photoStream.append(contentsOf: photosData)
    }
  }
}
