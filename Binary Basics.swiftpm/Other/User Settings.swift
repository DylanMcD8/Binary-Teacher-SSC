//
//  User Settings.swift
//  Binary Basics
//
//  Dylan McDonald | Swift Student Challenge 2025
//

import Foundation
import UIKit

class UserSettings {
    static var accentColor: AppleColors {
        get {
            return AppleColors(rawValue: UserDefaults.standard.string(forKey: "AccentColor") ?? "Gray") ?? .gray
        }
        set {
            UserDefaults.standard.setValue(newValue.rawValue, forKey: "AccentColor")
            NotificationCenter.default.post(name: Notification.Name("Update Theme Color"), object: nil)
        }
    }
}
