//
//  FadingTextView.swift
//  Binary Basics
//
//  Dylan McDonald | Swift Student Challenge 2025
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
        self.isEditable = false
        self.isSelectable = false
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
    
}

enum FadeEffect {
    case top
    case bottom
    case all
}

// Based on above
class FadingScrollView: UIScrollView, UIScrollViewDelegate {
    
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
    
}


func createAttributedMarkdownString(_ string: String, size: CGFloat = 35, lineSpacing: CGFloat = 10) -> NSAttributedString {
    do {
        let attributedString = try NSAttributedString(markdown: string, options: AttributedString.MarkdownParsingOptions(
            allowsExtendedAttributes: false,
            interpretedSyntax: .inlineOnlyPreservingWhitespace,
            failurePolicy: .returnPartiallyParsedIfPossible,
            languageCode: nil
        ))
        let mutableAttributedString = NSMutableAttributedString(attributedString: attributedString)
        let fullRange = NSRange(location: 0, length: mutableAttributedString.length)
        
        mutableAttributedString.enumerateAttribute(.font, in: fullRange, options: []) { value, range, _ in
            let newFont: UIFont
            if let currentFont = value as? UIFont,
               currentFont.fontDescriptor.symbolicTraits.contains(.traitBold) {
                newFont = UIFont.monospacedSystemFont(ofSize: size, weight: .black)
                //                    mutableAttrString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
//            } else if let currentFont = value as? UIFont,
//                      currentFont.fontDescriptor.symbolicTraits.contains(.traitItalic) {
//                newFont = UIFont.monospacedSystemFont(ofSize: 90, weight: .black)
            } else {
                newFont = UIFont.monospacedSystemFont(ofSize: size, weight: .regular)
            }
            mutableAttributedString.addAttribute(.font, value: newFont, range: range)
        }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        mutableAttributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: fullRange)
        
        return mutableAttributedString
    } catch {
        return NSAttributedString(string: string)
    }
}

