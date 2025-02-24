//
//  YourLabel.swift
//  Binary Basics
//
//  Created by Dylan McDonald on 2/23/25.
//

import UIKit

class FadingLabel: UILabel {
    private var isAnimatingTextChange = false
    
    override var text: String? {
        get {
            return super.text
        }
        
        set {
            // Already animating or text is the same
            if isAnimatingTextChange || newValue == super.text {
                super.text = newValue
                return
            }
            
            isAnimatingTextChange = true
            
            UIView.animate(withDuration: 0.15, delay: 0, options: .curveLinear, animations: {
                self.alpha = 0
                self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            }, completion: { _ in
                super.text = newValue
                
                UIView.animate(withDuration: 0.15, delay: 0, options: .curveLinear, animations: {
                    self.alpha = 1
                    self.transform = .identity
                }, completion: { _ in
                    self.isAnimatingTextChange = false
                })
            })
        }
    }
}
