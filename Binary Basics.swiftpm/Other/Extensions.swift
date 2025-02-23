//
//  Extensions.swift
//  Binary Basics
//
//  Dylan McDonald | Swift Student Challenge 2025
//

import UIKit

enum AppleColors: String {
    case blue = "Blue"
    case green = "Green"
    case red = "Red"
    case yellow = "Yellow"
    case orange = "Orange"
    case purple = "Purple"
    case gray = "Gray"
}

fileprivate func getSavedColor() -> UIColor {
    let savedColor = UserSettings.accentColor
    return convertAppleColorToUIColor(savedColor)
}

func convertAppleColorToUIColor(_ color: AppleColors) -> UIColor {
    switch color {
        case .blue:
            return UIColor(resource: .appleBlue)
        case .green:
            return UIColor(resource: .appleGreen)
        case .red:
            return UIColor(resource: .appleRed)
        case .yellow:
            return UIColor(resource: .appleYellow)
        case .orange:
            return UIColor(resource: .appleOrange)
        case .purple:
            return UIColor(resource: .applePurple)
        case .gray:
            return UIColor(resource: .appleGray)
    }
}

extension UIColor {
    static var currentColor: UIColor {
        get {
            return getSavedColor()
        }
    }

    
    func withBrightnessAdjustment(_ factor: CGFloat) -> UIColor {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        
        if self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            let newBrightness = max(min(brightness * factor, 1.0), 0.0) // Clamp between 0 and 1
            return UIColor(hue: hue, saturation: saturation, brightness: newBrightness, alpha: alpha)
        }
        
        return self // Fallback
    }
}

class BBViewController: UIViewController {
    var navigationView: BasicNavigationView?
}



func decimalToBinary(_ decimal: Int) -> [Int] {
    var decimal = decimal
    var binary: [Int] = []
    
    while decimal > 0 {
        binary.insert(decimal % 2, at: 0)
        decimal /= 2
    }
    
    return binary
}

    
