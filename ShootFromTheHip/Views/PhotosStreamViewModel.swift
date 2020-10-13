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
  private var page = 1
  private var pageSize = 10

  @Published var photoStream: [PhotoStreamCellData] = []
  
  init(photosFetcher: PhotosFetchable = PhotosFetcher()) {
    self.photosFetcher = photosFetcher
  }
  
  func refresh() {
    page = 1
    fetchPhotos()
  }
  
  func fetchPhotos() {
    photosFetcher.fetchPhotos(page: page, pageSize: pageSize) { [weak self] (photosResponse, nextPage, error) in
      guard let self = self, error == nil,
            let photos = photosResponse,
            let nextPage = nextPage
      else { return }

      self.page = nextPage
      let photosData = photos.map { (photo) -> PhotoStreamCellData in
        let imageURL = URL(string: photo.image.small)
        let heightWidthRatio = Double(photo.width) / Double(photo.height)
        return PhotoStreamCellData(
          heading: photo.id,
          imageURL: imageURL,
          heightWidthRatio: heightWidthRatio
        )
      }
      guard !photosData.isEmpty else { return }
      
      if self.page == 1 {
        self.photoStream = photosData
      } else {
        self.photoStream.append(contentsOf: photosData)
      }
    }
  }
}
