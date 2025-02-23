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

class StaticBinaryNumberView: UIView {
    
    var value: BinaryValue = .zero {
        didSet {
            if value == .empty {
                binaryLabel.text = ""
            } else {
                binaryLabel.text = "\(value.rawValue)"
            }
        }
    }
    var subtitleText: String = "" {
        didSet {
            if subtitleText.isEmpty {
                subtitleLabel.isHidden = true
                subtitleLabel.text = ""
                mainBottomConstraint = binaryLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
            } else {
                subtitleLabel.isHidden = false
                subtitleLabel.text = subtitleText
                mainBottomConstraint = binaryLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: -5)
            }
            if self.subviews.contains(subtitleLabel) && self.subviews.contains(binaryLabel) {
                mainBottomConstraint.isActive = true
            }
        }
    }
    
    var binaryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.monospacedSystemFont(ofSize: 75, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.monospacedSystemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var mainBottomConstraint: NSLayoutConstraint!
    
    
    init(value: BinaryValue, subtitleText: String, binaryLabel: UILabel, subtitleLabel: UILabel) {
        self.value = value
        self.binaryLabel = binaryLabel
        self.subtitleLabel = subtitleLabel
        super.init(frame: .zero)
        
        self.backgroundColor = .white.withAlphaComponent(0.3)
        self.layer.cornerRadius = 30
        self.layer.cornerCurve = .continuous
        self.layer.borderColor = UIColor.white.withAlphaComponent(0.3).cgColor
        self.layer.borderWidth = 5
        
        self.addSubview(self.binaryLabel)
        self.addSubview(self.subtitleLabel)
        self.subtitleText = subtitleText
        
        NSLayoutConstraint.activate([
            self.binaryLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.binaryLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.binaryLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            self.subtitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            self.subtitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.subtitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
        
//        if subtitleText.isEmpty {
//            self.subtitleLabel.isHidden = true
//            mainBottomConstraint = binaryLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
//        } else {
//            self.subtitleLabel.isHidden = false
//            mainBottomConstraint = binaryLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: 5)
//        }
//        mainBottomConstraint.isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
