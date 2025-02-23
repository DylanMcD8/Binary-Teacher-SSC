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
            return AppleColors(rawValue: UserDefaults.standard.string(forKey: "App Accent Color") ?? "Gray") ?? .gray
        }
        set {
            UserDefaults.standard.setValue(newValue.rawValue, forKey: "App Accent Color")
        }
    }
}
