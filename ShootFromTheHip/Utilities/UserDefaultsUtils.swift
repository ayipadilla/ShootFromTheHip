//
//  UserDefaultsUtils.swift
//  ShootFromTheHip
//
//  Created by Ayi Padilla on 10/15/20.
//

import Foundation

class UserDefaultsUtils {
  static private let kAppearanceMode = "AppearanceMode"

  enum AppearanceMode: Int {
    case automatic = 0
    case light = 1
    case dark = 2
  }
  
  class func setAppearanceMode(_ mode: AppearanceMode) {
    UserDefaults.standard.setValue(mode.rawValue, forKey: kAppearanceMode)
    UserDefaults.standard.synchronize()
  }
  
  class var appearanceMode: AppearanceMode {
    get {
      if let value = UserDefaults.standard.object(forKey: kAppearanceMode),
         let intValue = value as? Int,
         let mode = AppearanceMode(rawValue: intValue) {
        return mode
      }
      return AppearanceMode.automatic
    }
  }
}
