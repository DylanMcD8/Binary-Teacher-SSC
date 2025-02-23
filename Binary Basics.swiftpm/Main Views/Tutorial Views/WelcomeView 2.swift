//
//  WelcomeView.swift
//  Binary Basics
//
//  Created by Dylan McDonald on 2/22/25.
//

import UIKit

class WelcomeView2: BBViewController {
    
    let titleString = "Welcome! 👋"
    let welcomeString = "Hey there! :) My name is **Dylan**, and I’m a Software Engineering student at the **Rochester Institute of Technology**. I’m also a lifelong Apple fan! When I first started learning Computer Science in high school, one of the first concepts I encountered was **binary**. However, I found it challenging to grasp at first. Inspired by this experience, I decided to create a project that aims to teach binary in a simple and concise manner. **Welcome to Binary Basics!**"
    
    // View Elements
    let mainLabel = UILabel()
    let chooseColorTitle = UILabel()
    let colorsStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationView?.isForwardEnabled = false
        do {
            let attrString = try NSAttributedString(markdown: welcomeString)
            let mutableAttrString = NSMutableAttributedString(attributedString: attrString)
            let fullRange = NSRange(location: 0, length: mutableAttrString.length)

            mutableAttrString.enumerateAttribute(.font, in: fullRange, options: []) { value, range, _ in
                let newFont: UIFont
                if let currentFont = value as? UIFont,
                   currentFont.fontDescriptor.symbolicTraits.contains(.traitBold) {
                    newFont = UIFont.monospacedSystemFont(ofSize: 30, weight: .black)
//                    mutableAttrString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
                } else {
                    newFont = UIFont.monospacedSystemFont(ofSize: 30, weight: .regular)
                }
                mutableAttrString.addAttribute(.font, value: newFont, range: range)
            }
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 15.0
            mutableAttrString.addAttribute(.paragraphStyle, value: paragraphStyle, range: fullRange)
            
            mainLabel.attributedText = mutableAttrString
        } catch {
            mainLabel.text = welcomeString
        }
        mainLabel.numberOfLines = 0
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
//        mainLabel.font = UIFont.monospacedSystemFont(ofSize: 30, weight: .medium)
        mainLabel.numberOfLines = 0
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mainLabel)
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            mainLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            mainLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0)
        ])
        
        chooseColorTitle.text = "Choose a color to get started:"
        chooseColorTitle.font = UIFont.monospacedSystemFont(ofSize: 25, weight: .semibold)
        chooseColorTitle.textAlignment = .center
        chooseColorTitle.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(chooseColorTitle)
        NSLayoutConstraint.activate([
            chooseColorTitle.topAnchor.constraint(greaterThanOrEqualTo: mainLabel.bottomAnchor, constant: 50),
            chooseColorTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            chooseColorTitle.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0)
        ])
        
        colorsStackView.axis = .horizontal
        colorsStackView.distribution = .fillEqually
        colorsStackView.spacing = 15
        colorsStackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(colorsStackView)
        NSLayoutConstraint.activate([
            colorsStackView.topAnchor.constraint(equalTo: chooseColorTitle.bottomAnchor, constant: 15),
            colorsStackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
            colorsStackView.leadingAnchor.constraint(greaterThanOrEqualTo: self.view.leadingAnchor, constant: 0),
            colorsStackView.trailingAnchor.constraint(lessThanOrEqualTo: self.view.trailingAnchor, constant: 0),
            colorsStackView.heightAnchor.constraint(equalToConstant: 50),
            colorsStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
        let colors: [AppleColors] = [.green, .yellow, .orange, .red, .purple, .blue]
        var buttons: [UIButton] = []
        for color in colors {
            let button = UIButton()
            button.setTitle(color.rawValue, for: .normal)
            button.setTitleColor(.label, for: .normal)
            button.backgroundColor = convertAppleColorToUIColor(color)
            button.heightAnchor.constraint(equalToConstant: 50).isActive = true
            button.widthAnchor.constraint(equalToConstant: 50).isActive = true
            button.layer.cornerRadius = 50 / 2
            button.translatesAutoresizingMaskIntoConstraints = false
            button.layer.borderColor = UIColor.label.withAlphaComponent(0.3).cgColor
            let isCurrentColor = UserSettings.accentColor == color
            button.layer.borderWidth = isCurrentColor ? 26 : 3
            button.tag = colors.firstIndex(of: color) ?? 0
            colorsStackView.addArrangedSubview(button)
            buttons.append(button)
            
            let action = UIAction { _ in
                for button in buttons {
                    UIView.animate(withDuration: 0.3) {
                        let buttonIsSelf = button.tag == colors.firstIndex(of: color) ?? 0
                        button.layer.borderWidth = buttonIsSelf ? 26 : 3
                    }
                }
                
                UserSettings.accentColor = color
                self.navigationView?.accentColor = .currentColor
                self.navigationView?.isForwardEnabled = true
            }
            button.addAction(action, for: .touchUpInside)
            
            
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
            
        }
    }
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        DispatchQueue.main.async {
            self.navigationView?.isForwardEnabled = false
        }
    }
    
}
