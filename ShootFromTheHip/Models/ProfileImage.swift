//
//  ProfileImage.swift
//  ShootFromTheHip
//
//  Created by Ayi Padilla on 10/14/20.
//

import Foundation

struct ProfileImage: Decodable {
  let small: String
  let medium: String
  let large: String

  enum CodingKeys: String, CodingKey {
    case small
    case medium
    case large
  }
}
