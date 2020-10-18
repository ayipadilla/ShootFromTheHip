//
//  UnsplashAPI.swift
//  ShootFromTheHip
//
//  Created by Ayi Padilla on 10/14/20.
//

import Foundation

struct UnsplashAPI {
  static let scheme = "https"
  static let host = "api.unsplash.com"
  static let clientID = "Pm6ajiHX9W503Rqy9keBor1KnYLVVx_rYgksBtXK8Hc"
  static let acceptVersion = "v1"
  
  static let authorizationPrefix = "Client-ID "
  static let authorizationKey = "Authorization"
  static let acceptVersionKey = "Accept-Version"
  
  static let requestParamOrderBy = "order_by"
  static let requestParamPage = "page"
  static let requestParamPageSize = "per_page"
}
