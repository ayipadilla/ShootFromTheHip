//
//  PhotoImage.swift
//  ShootFromTheHip
//
//  Created by Ayi Padilla on 10/13/20.
//

import Foundation

struct PhotoImage: Decodable {
  let full: String
  let small: String
  let thumb: String
  let regular: String
  let raw: String
  
  enum CodingKeys: String, CodingKey {
    case full
    case small
    case thumb
    case regular
    case raw
  }
}
