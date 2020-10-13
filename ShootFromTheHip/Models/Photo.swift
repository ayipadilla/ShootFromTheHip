//
//  Photo.swift
//  ShootFromTheHip
//
//  Created by Ayi Padilla on 10/13/20.
//

import Foundation

struct Photo: Decodable {
  let id: Int
  let width: Int
  let height: Int
  let color: String?
  let description: String?
  let image: PhotoImage
  
  enum CodingKeys: String, CodingKey {
    case id
    case width
    case height
    case color
    case description
    case image = "urls"
  }
  
}
