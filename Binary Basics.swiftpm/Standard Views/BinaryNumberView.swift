//
//  BinaryNumberView.swift
//  Binary Basics
//
//  Dylan McDonald | Swift Student Challenge 2025
//

import UIKit

enum BinaryValue: Int {
    case zero = 0
    case one = 1
    case empty = -1
}

class BinaryNumberView: UIView {
    var sourceView: BinaryNumberHostViewController?
    var index: Int = 0
    var isEditable: Bool = false
    var value: BinaryValue = .zero {
        didSet {
            updateValue()
        }
    }
    private var subtitleText: String = ""
    
    private func updateValue(/*animated: Bool = false*/) {
        if self.value == .empty {
            self.binaryLabel.text = " "
        } else {
            self.binaryLabel.text = "\(self.value.rawValue)"
        }
    }
    
    func updateSubtitle(_ with: String, animated: Bool = true, forceLineNumber: Int = 2) {
        
        if subtitleText.isEmpty != with.isEmpty {
            self.subtitleText = with
            self.subtitleLabel.numberOfLines = forceLineNumber
            self.subtitleLabel.text = self.subtitleText
            let animations = {
                if self.subtitleText.isEmpty {
                    self.subtitleLabel.alpha = 0
                    self.bottomConstraint.constant = -10
                } else {
                    self.subtitleLabel.alpha = 1
                }
                self.binaryLabel.invalidateIntrinsicContentSize()
                self.setNeedsLayout()
                self.layoutIfNeeded()
            }
            
            if animated {
                UIView.animate(withDuration: 0.3, animations: animations, completion: {
                    _ in
                    UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                        if self.subtitleText.isEmpty {
                            self.bottomConstraint.constant = -10
                        } else {
                            self.bottomConstraint.constant = -(10 + max(30, self.subtitleLabel.frame.height) + 5)
                        }
                        //                    print(self.subtitleLabel.frame.height)
                        self.setNeedsLayout()
                        self.layoutIfNeeded()
                    }
                })
            } else {
                animations()
                self.bottomConstraint.constant = -(10 + max(30, self.subtitleLabel.frame.height) + 5)
                self.setNeedsLayout()
                self.layoutIfNeeded()
            }
        } else {
            self.subtitleText = with
            self.subtitleLabel.numberOfLines = forceLineNumber
            self.subtitleLabel.text = self.subtitleText
            if animated {
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                    if self.subtitleText.isEmpty {
                        self.bottomConstraint.constant = -10
                    } else {
                        self.bottomConstraint.constant = -(10 + max(30, self.subtitleLabel.frame.height) + 5)
                    }
                    self.setNeedsLayout()
                    self.layoutIfNeeded()
                }
            } else {
                if self.subtitleText.isEmpty {
                    self.bottomConstraint.constant = -10
                } else {
                    self.bottomConstraint.constant = -(10 + max(30, self.subtitleLabel.frame.height) + 5)
                }
                self.setNeedsLayout()
                self.layoutIfNeeded()
            }
        }
    }
    
    private var binaryLabel: FadingLabel = {
        let label = FadingLabel()
        label.font = UIFont.monospacedSystemFont(ofSize: 100, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var subtitleLabel: FadingLabel = {
        let label = FadingLabel()
        label.font = UIFont.monospacedSystemFont(ofSize: 25, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var tapGestureRecognizer = UITapGestureRecognizer()

    
    var bottomConstraint: NSLayoutConstraint!
    
    init(value: BinaryValue, subtitleText: String, index: Int, isEditable: Bool = false, sourceView: BinaryNumberHostViewController? = nil) {
        self.subtitleText = subtitleText
        self.value = value
        self.index = index
        self.isEditable = isEditable
        self.sourceView = sourceView
        super.init(frame: .zero)
        
        self.isUserInteractionEnabled = isEditable
        self.tapGestureRecognizer.addTarget(self, action: #selector(tapped))
        self.addGestureRecognizer(self.tapGestureRecognizer)
        
        self.backgroundColor = .white.withAlphaComponent(0.2)
        self.layer.cornerRadius = 30
        self.layer.cornerCurve = .continuous
        self.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
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
        
        if subtitleText.isEmpty {
            self.subtitleLabel.alpha = 0
        } else {
            self.subtitleLabel.alpha = 1
        }
        
        
        updateValue()
        updateSubtitle(subtitleText, animated: false)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tapped() {
        self.value = self.value == .one ? .zero : .one
        UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }, completion: { _ in
            UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseInOut) {
                self.transform = .identity
            }
        })

        sourceView?.updateBinaryNumber(forIndex: index, withValue: value.rawValue)
    }

}
