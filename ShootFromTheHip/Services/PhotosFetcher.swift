//
//  PhotosFetcher.swift
//  ShootFromTheHip
//
//  Created by Ayi Padilla on 10/14/20.
//

import Foundation

protocol PhotosFetchable {
  func fetchPhotos(page: Int, pageSize: Int, completion: @escaping ([Photo]?, Int?, Error?) -> Void)
}

enum PhotosFetcherError: Error {
  case invalidURL
  case parsing(Error)
  case request(Error)
  
  var description: String {
    switch self {
    case .invalidURL:
      return "Invalid URL"
    case .parsing(let error):
      return "Decoding failed: \(error.localizedDescription)"
    case .request(let error):
      return "Network request error \(error.localizedDescription)"
    }
  }
}

class PhotosFetcher: PhotosFetchable {
  private let defaultSession = URLSession(configuration: .default)
  private var dataTask: URLSessionDataTask?
  
  static let pageSize = 10

  func fetchPhotos(page: Int = 1, pageSize: Int = pageSize, completion: @escaping ([Photo]?, Int?, Error?) -> Void) {
    dataTask?.cancel()
    let URLComponents = getURLComponents(page: page, pageSize: pageSize)
    guard let url = URLComponents.url else {
      completion(nil, nil, PhotosFetcherError.invalidURL)
      return
    }
    
    let request = getURLRequest(url)
    
    dataTask = defaultSession.dataTask(with: request, completionHandler: { (data, response, error) in
      guard let dataResponse = data else {
        if let error = error {
          completion(nil, nil, PhotosFetcherError.request(error))
        }
        return
      }
      
      do {
        let decoder = JSONDecoder()
        let photos = try decoder.decode([Photo].self, from: dataResponse)
        completion(photos, page + 1, nil)
      } catch {
        completion(nil, nil, PhotosFetcherError.parsing(error))
      }
    })
    dataTask?.resume()
  }
  
  private func getURLRequest(_ url: URL) -> URLRequest {
    var request = URLRequest(url: url)
    let authorization = UnsplashAPI.authorizationPrefix + UnsplashAPI.clientID
    request.setValue(authorization , forHTTPHeaderField: UnsplashAPI.authorizationKey)
    request.setValue(UnsplashAPI.acceptVersion, forHTTPHeaderField: UnsplashAPI.acceptVersionKey)
    return request
  }
  
  private func getURLComponents(page:Int, pageSize: Int) -> URLComponents {
    var components = URLComponents()
    components.scheme = UnsplashAPI.scheme
    components.host = UnsplashAPI.host
    components.path = "/photos"
    
    components.queryItems = [
      URLQueryItem(name: "order_by", value: "popular"),
      URLQueryItem(name: "page", value: String(page)),
      URLQueryItem(name: "per_page", value: String(pageSize))
    ]
    
    return components
  }
}

