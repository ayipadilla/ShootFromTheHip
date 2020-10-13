//
//  PhotosFetcher.swift
//  ShootFromTheHip
//
//  Created by Ayi Padilla on 10/14/20.
//

import Foundation

protocol PhotosFetchable {
  func fetchPhotos(completion: @escaping ([Photo]?, Error?) -> Void)
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
  
  func fetchPhotos(completion: @escaping ([Photo]?, Error?) -> Void) {
    dataTask?.cancel()
    let URLComponents = getURLComponents()
    guard let url = URLComponents.url else {
      completion(nil, PhotosFetcherError.invalidURL)
      return
    }
    
    let request = getURLLrequest(url)
    
    dataTask = defaultSession.dataTask(with: request, completionHandler: { (data, response, error) in
      guard let dataResponse = data else {
        if let error = error {
          completion(nil, PhotosFetcherError.request(error))
        }
        return
      }
      
      do {
        let decoder = JSONDecoder()
        let photos = try decoder.decode([Photo].self, from: dataResponse)
        completion(photos, nil)
      } catch {
        completion(nil, PhotosFetcherError.parsing(error))
      }
    })
    dataTask?.resume()
  }
  
  private func getURLLrequest(_ url: URL) -> URLRequest {
    var request = URLRequest(url: url)
    let authorization = UnsplashAPI.authorizationPrefix + UnsplashAPI.clientID
    request.setValue(authorization , forHTTPHeaderField: UnsplashAPI.authorizationKey)
    request.setValue(UnsplashAPI.acceptVersion, forHTTPHeaderField: UnsplashAPI.acceptVersionKey)
    return request
  }
  
  private func getURLComponents() -> URLComponents {
    var components = URLComponents()
    components.scheme = UnsplashAPI.scheme
    components.host = UnsplashAPI.host
    components.path = "/photos"
    
    components.queryItems = [
      URLQueryItem(name: "order_by", value: "popular"),
    ]
    
    return components
  }
}

