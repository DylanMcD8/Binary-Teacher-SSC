//
//  NavigationButton.swift
//  Binary Basics
//
//  Dylan McDonald | Swift Student Challenge 2025
//

import UIKit

func navigationButton(title: String, iconName: String, iconPlacement: NSDirectionalRectEdge = .leading, action: UIAction?) -> UIButton {
    var configuration = UIButton.Configuration.tinted()
    configuration.cornerStyle = .capsule
    configuration.baseForegroundColor = .label
    configuration.image = UIImage(systemName: iconName)
    configuration.imagePadding = 8
    configuration.imagePlacement = iconPlacement
    configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold, scale: .medium)
    configuration.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 15, bottom: 12, trailing: 15)
    
    configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
        var outgoing = incoming
        outgoing.font = .monospacedSystemFont(ofSize: 25, weight: .semibold)
        return outgoing
    }
    
    let button = UIButton(configuration: configuration, primaryAction: action)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.toolTip = title
    button.preferredBehavioralStyle = .pad
    button.tintColor = .label
    button.isPointerInteractionEnabled = true
    button.setTitle(title, for: .normal)
    button.setTitleColor(.label, for: .normal)
    
    button.configurationUpdateHandler = { button in
        if button.isHighlighted {
            UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseInOut) {
                button.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                button.alpha = 0.65
            }
        } else {
            UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseInOut) {
                button.transform = .identity
                button.alpha = 1
            }
        }
    }
    
    return button
}
