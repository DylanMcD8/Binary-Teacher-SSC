//
//  FadingTextView.swift
//  Binary Basics
//
//  Created by Dylan McDonald on 2/23/25.
//

import UIKit

// ATTRIBUTION: Mr.SwiftOak on StackOverflow, https://stackoverflow.com/questions/24614691/fade-out-scrolling-uitextview-over-image
class FadingTextView: UITextView, UITextViewDelegate {
    
    let fadePercentage: Double = 0.1
    let gradientLayer = CAGradientLayer()
    let transparentColor = UIColor.clear.cgColor
    let opaqueColor = UIColor.black.cgColor
    
    let fadeEffect: FadeEffect = .all
    
    var topOpacity: CGColor {
        let scrollViewHeight = frame.size.height
        let scrollContentSizeHeight = contentSize.height
        let scrollOffset = contentOffset.y
        
        let alpha: CGFloat = (scrollViewHeight >= scrollContentSizeHeight || scrollOffset <= 0) ? 1 : 0
        
        let color = UIColor(white: 0, alpha: alpha)
        return color.cgColor
    }
    
    var bottomOpacity: CGColor {
        let scrollViewHeight = frame.size.height
        let scrollContentSizeHeight = contentSize.height
        let scrollOffset = contentOffset.y
        
        let alpha: CGFloat = (scrollViewHeight >= scrollContentSizeHeight || scrollOffset + scrollViewHeight >= scrollContentSizeHeight) ? 1 : 0
        
        let color = UIColor(white: 0, alpha: alpha)
        return color.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.delegate = self
        let maskLayer = CALayer()
        maskLayer.frame = self.bounds
        
        setFadeEffect()
        maskLayer.addSublayer(gradientLayer)
        
        self.layer.mask = maskLayer
        
        self.delegate = self // setting self as delegate so `scrollViewDidScroll(_:)` can be triggered
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        setFadeEffect()
    }
    
    func setFadeEffect() {
        switch fadeEffect {
            case .top:
                gradientLayer.colors = [topOpacity, opaqueColor, opaqueColor, opaqueColor]
            case .bottom:
                gradientLayer.colors = [opaqueColor, opaqueColor, opaqueColor, bottomOpacity]
            case .all:
                gradientLayer.colors = [topOpacity, opaqueColor, opaqueColor, bottomOpacity]
        }
        
        gradientLayer.frame = CGRect(x: self.bounds.origin.x, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
        gradientLayer.locations = [0, NSNumber(floatLiteral: fadePercentage), NSNumber(floatLiteral: 1 - fadePercentage), 1]
    }
    
    enum FadeEffect {
        case top
        case bottom
        case all
    }
}
