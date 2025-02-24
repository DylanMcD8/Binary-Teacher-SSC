//
//  WelcomeVC.swift
//  Binary Basics
//
//  Dylan McDonald | Swift Student Challenge 2025
//

import UIKit

class WelcomeVC: BBViewController {
    
    let welcomeString = "Hey there! :)  My name is **Dylan**, and I'm a Software Engineering student at **Rochester Institute of Technology**, and a lifelong Apple fan! When I first started learning Computer Science in high school, one of the first things I learned about was **binary**, but I struggled to understand it at first. So, I wanted to create a project based on that experience that teaches binary in a simple and quick way. **Welcome to Binary Basics!**"
    
    // View Elements
    let orientationLabel = UILabel()
    let mainTextView = FadingTextView()
    let chooseColorTitle = UILabel()
    let colorsStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.navigationView?.isForwardEnabled = false
        }
        orientationLabel.text = "Note: this app is best experienced in landscape orientation."
        orientationLabel.numberOfLines = 0
        orientationLabel.font = UIFont.monospacedSystemFont(ofSize: 20, weight: .bold)
        orientationLabel.textAlignment = .center
        orientationLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(orientationLabel)
        NSLayoutConstraint.activate([
            orientationLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            orientationLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            orientationLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0)
        ])
        
        mainTextView.attributedText = createAttributedMarkdownString(welcomeString)
        mainTextView.isScrollEnabled = true
        mainTextView.textColor = .label
        mainTextView.backgroundColor = .clear
        mainTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        mainTextView.textContainerInset = .zero
        mainTextView.translatesAutoresizingMaskIntoConstraints = false

//        mainLabel.font = UIFont.monospacedSystemFont(ofSize: 30, weight: .medium)
        self.view.addSubview(mainTextView)
        NSLayoutConstraint.activate([
            mainTextView.topAnchor.constraint(equalTo: orientationLabel.bottomAnchor, constant: 10),
            mainTextView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            mainTextView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
        ])
        
       
        
        
        
        
        chooseColorTitle.text = "Choose a color to get started:"
        chooseColorTitle.font = UIFont.monospacedSystemFont(ofSize: 25, weight: .semibold)
        chooseColorTitle.textAlignment = .center
        chooseColorTitle.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(chooseColorTitle)
        NSLayoutConstraint.activate([
            mainTextView.bottomAnchor.constraint(equalTo: chooseColorTitle.topAnchor, constant: -30),
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
            button.layer.borderColor = UIColor.white.withAlphaComponent(0.3).cgColor
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
//        guard parent == nil else { return }
//        DispatchQueue.main.async {
//            self.navigationView?.isForwardEnabled = false
//        }
    }
    
}
