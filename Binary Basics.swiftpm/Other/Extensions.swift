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

protocol BinaryNumberHostViewController: AnyObject {
    func updateBinaryNumber(forIndex index: Int, withValue value: Int)
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

func binaryToDecimal(_ binary: [Int]) -> Int {
    var decimal = 0
    for (index, bit) in binary.reversed().enumerated() {
        decimal += bit * Int(pow(2, Double(index)))
    }
    return decimal
}
    
extension UIColor {
    // Apple Colors
    static var appleGray: UIColor {
        return UIColor(red: 161, green: 160, blue: 161, alpha: 1)
    }
    static var appleBlue: UIColor {
        return UIColor(red: 51, green: 111, blue: 198, alpha: 1)
    }
    static var appleGreen: UIColor {
        return UIColor(red: 79, green: 155, blue: 148, alpha: 1)
    }
    static var appleOrange: UIColor {
        return UIColor(red: 238, green: 113, blue: 79, alpha: 1)
    }
    static var appleYellow: UIColor {
        return UIColor(red: 242, green: 165, blue: 59, alpha: 1)
    }
    static var appleRed: UIColor {
        return UIColor(red: 192, green: 67, blue: 64, alpha: 1)
    }
    static var applePurple: UIColor {
        return UIColor(red: 92, green: 69, blue: 191, alpha: 1)
    }
}
