//
//  AboutViewModel.swift
//  ShootFromTheHip
//
//  Created by Ayi Padilla on 10/15/20.
//

import Foundation

class AboutViewModel {
  var appDisplayName: String {
    if let name = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String {
        return name
    } else if let name = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String {
        return name
    }
    return ""
  }
  
  var appVersion: String {
    if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
      return "Version \(version)"
    }
    return ""
  }
  
  var iconCredits: String {
    let icons = [
      "Ionicons https://ionicons.com/",
      "Unsplash https://unsplash.com/"
    ]
    let text = icons.joined(separator: "\n")
    return text
  }
}
