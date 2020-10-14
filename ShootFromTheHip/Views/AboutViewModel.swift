//
//  AboutViewModel.swift
//  ShootFromTheHip
//
//  Created by Ayi Padilla on 10/15/20.
//

import Foundation
import UIKit

class AboutViewModel {

  enum AppearanceSegment: Int {
    case automatic = 0
    case light = 1
    case dark = 2
  }

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
  
  var appCredits: String {
    let icons = [
      "Ionicons https://ionicons.com/",
      "Unsplash https://unsplash.com/"
    ]
    let text = icons.joined(separator: "\n")
    return text
  }
  
  var appearanceSelectedSegment: Int = 0
  
  init() {
    let appearanceMode = UserDefaultsUtils.appearanceMode
    switch appearanceMode {
    case .light:
      appearanceSelectedSegment = AppearanceSegment.light.rawValue
    case .dark:
      appearanceSelectedSegment = AppearanceSegment.dark.rawValue
    default:
      appearanceSelectedSegment = AppearanceSegment.automatic.rawValue
    }
  }
  
  func selectedAppearanceMode(_ index: Int) {
    switch index {
    case AppearanceSegment.light.rawValue:
      UserDefaultsUtils.setAppearanceMode(.light)
      UIApplication.shared.windows.first!.overrideUserInterfaceStyle = .light
    case AppearanceSegment.dark.rawValue:
      UserDefaultsUtils.setAppearanceMode(.dark)
      UIApplication.shared.windows.first!.overrideUserInterfaceStyle = .dark
    default:
      UserDefaultsUtils.setAppearanceMode(.automatic)
      UIApplication.shared.windows.first!.overrideUserInterfaceStyle = .unspecified
    }
  }
}
