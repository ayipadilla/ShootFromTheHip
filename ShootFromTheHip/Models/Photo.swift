//
//  Photo.swift
//  ShootFromTheHip
//
//  Created by Ayi Padilla on 10/13/20.
//

import Foundation

struct Photo: Decodable {
  let id: String
  let width: Int
  let height: Int
  let color: String?
  let description: String?
  let image: PhotoImage
  let user: User
  
  enum CodingKeys: String, CodingKey {
    case id
    case width
    case height
    case color
    case description
    case image = "urls"
    case user
  }
}
