//
//  User.swift
//  ShootFromTheHip
//
//  Created by Ayi Padilla on 10/14/20.
//

import Foundation

struct User: Decodable {
  let id: String
  let name: String?
  let firstName: String?
  let lastName: String?
  let profileImage: ProfileImage?
  
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case firstName = "first_name"
    case lastName = "last_name"
    case profileImage = "profile_image"
  }
}
