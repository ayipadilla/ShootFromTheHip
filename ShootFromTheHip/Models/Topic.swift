//
//  Topic.swift
//  ShootFromTheHip
//
//  Created by Ayi Padilla on 10/14/20.
//

import Foundation

struct Topic: Decodable {
  let id: Int
  let slug: String
  let title: String
  let description: String?
  
  enum CodingKeys: String, CodingKey {
    case id
    case slug
    case title
    case description
  }
}
