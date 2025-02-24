//
//  StaticBinaryNumberView.swift
//  Binary Basics
//
//  Created by Dylan McDonald on 2/22/25.
//

import UIKit

enum BinaryValue: Int {
    case zero = 0
    case one = 1
    case empty = -1
}

class BinaryNumberView: UIView {
    
    var value: BinaryValue = .zero {
        didSet {
            updateValue()
        }
    }
    var subtitleText: String = "" {
        didSet {
            updateSubtitle()
        }
    }
    
    private func updateValue(animated: Bool = true) {
        let animations = {
            if self.value == .empty {
                self.binaryLabel.text = ""
            } else {
                self.binaryLabel.text = "\(self.value.rawValue)"
            }
            self.layoutIfNeeded()
        }
        if animated {
            UIView.animate(withDuration: 0.2, animations: animations)
        } else {
            animations()
        }
    }
    
    private func updateSubtitle(animated: Bool = true) {
        self.subtitleLabel.text = self.subtitleText
//        self.subtitleLabel.invalidateIntrinsicContentSize()
//        self.binaryLabel.invalidateIntrinsicContentSize()
        let animations = {
//            NSLayoutConstraint.deactivate([self.bottomConstraint, self.withoutSubtitleConstraint])
//            self.invalidateIntrinsicContentSize()
//            self.subtitleLabel.invalidateIntrinsicContentSize()
//            self.binaryLabel.invalidateIntrinsicContentSize()
//            self.setNeedsLayout()
//            self.layoutIfNeeded()
            if self.subtitleText.isEmpty {
                self.subtitleLabel.alpha = 0
                self.bottomConstraint.constant = -10
            } else {
                self.subtitleLabel.alpha = 1
                self.bottomConstraint.constant = -(10 + 24.75 + 5)
            }
//            self.invalidateIntrinsicContentSize()
            self.binaryLabel.invalidateIntrinsicContentSize()
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
        
        if animated {
            UIView.animate(withDuration: 0.2, animations: animations)
        } else {
            animations()
        }
    }
    
    private var binaryLabel: FadingLabel = {
        let label = FadingLabel()
        label.font = UIFont.monospacedSystemFont(ofSize: 200, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var subtitleLabel: FadingLabel = {
        let label = FadingLabel()
        label.font = UIFont.monospacedSystemFont(ofSize: 23, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var bottomConstraint: NSLayoutConstraint!
//    var withoutSubtitleConstraint: NSLayoutConstraint!
    
    init(value: BinaryValue, subtitleText: String) {
        self.subtitleText = subtitleText
        self.value = value
        super.init(frame: .zero)
        
        self.backgroundColor = .white.withAlphaComponent(0.3)
        self.layer.cornerRadius = 30
        self.layer.cornerCurve = .continuous
        self.layer.borderColor = UIColor.white.withAlphaComponent(0.3).cgColor
        self.layer.borderWidth = 5
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(self.binaryLabel)
        self.addSubview(self.subtitleLabel)
        
        binaryLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        subtitleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        
        NSLayoutConstraint.activate([
            self.binaryLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.binaryLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.binaryLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            self.subtitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            self.subtitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.subtitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
        
        self.bottomConstraint = self.binaryLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        bottomConstraint.isActive = true
//        self.withoutSubtitleConstraint = self.binaryLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        
        if subtitleText.isEmpty {
//            self.withoutSubtitleConstraint.isActive = true
            self.subtitleLabel.alpha = 0
        } else {
//            self.bottomConstraint.isActive = true
            self.subtitleLabel.alpha = 1
        }
        
        binaryLabel.text = "\(value.rawValue)"
        subtitleLabel.text = subtitleText
        
        
//            updateValue(animated: false)
//            updateSubtitle(animated: false)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
