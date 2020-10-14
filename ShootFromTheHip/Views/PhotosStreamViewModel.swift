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

  @Published var photoStream: [PhotoStreamData] = []
  private var photos: [Photo] = []

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
      let photosData = photos.map { (photo) -> PhotoStreamData in
        let previewImageURL = URL(string: photo.image.regular)
        let fullImageURL = URL(string: photo.image.raw)
        let heightWidthRatio = Double(photo.height) / Double(photo.width)
        return PhotoStreamData(
          heading: photo.user.name ?? "",
          previewImageURL: previewImageURL,
          fullImageURL: fullImageURL,
          heightWidthRatio: heightWidthRatio
        )
      }
      guard !photosData.isEmpty else { return }
      
      if self.page == 1 {
        self.photoStream = photosData
        self.photos = photos
      } else {
        self.photoStream.append(contentsOf: photosData)
        self.photos.append(contentsOf: photos)
      }
    }
  }

  func photoDetailView(at index: Int) -> PhotoDetailViewController? {
    guard index >= 0, index < photos.count else { return nil }
    let photoDetailViewCOntroller = PhotoDetailViewController(nibName: PhotoDetailViewController.nibName, bundle: nil)
    let cellData = photoStream[index]
    let viewModel = photoDetailViewCOntroller.viewModel
    viewModel.previewImageURL = cellData.previewImageURL
    viewModel.photoImageURL = cellData.fullImageURL
    viewModel.heightWidthRatio = cellData.heightWidthRatio
    return photoDetailViewCOntroller
  }
}
