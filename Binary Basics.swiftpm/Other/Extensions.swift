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
        return .appleBlue
        case .green:
        return .appleGreen
        case .red:
        return .appleRed
        case .yellow:
        return .appleYellow
        case .orange:
        return .appleOrange
        case .purple:
        return .applePurple
        case .gray:
        return .appleGray
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
    // Apple colors
    static var appleGray: UIColor {
        return UIColor(red: 161/255, green: 160/255, blue: 161/255, alpha: 1)
    }
    static var appleBlue: UIColor {
        return UIColor(red: 51/255, green: 111/255, blue: 198/255, alpha: 1)
    }
    static var appleGreen: UIColor {
        return UIColor(red: 79/255, green: 155/255, blue: 148/255, alpha: 1)
    }
    static var appleOrange: UIColor {
        return UIColor(red: 238/255, green: 113/255, blue: 79/255, alpha: 1)
    }
    static var appleYellow: UIColor {
        return UIColor(red: 242/255, green: 165/255, blue: 59/255, alpha: 1)
    }
    static var appleRed: UIColor {
        return UIColor(red: 192/255, green: 67/255, blue: 64/255, alpha: 1)
    }
    static var applePurple: UIColor {
        return UIColor(red: 92/255, green: 69/255, blue: 191/255, alpha: 1)
    }
}
