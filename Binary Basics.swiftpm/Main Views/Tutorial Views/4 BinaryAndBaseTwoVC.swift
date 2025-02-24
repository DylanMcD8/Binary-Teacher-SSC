//
//  WelcomeView.swift
//  Binary Basics
//
//  Created by Dylan McDonald on 2/22/25.
//

import UIKit

class BinaryAndBase2VC: BBViewController {

    let instructionText = "Chances are you've seen binary before. For example, here's the number **214** in binary:"
    let binaryExampleNumber: [BinaryValue] = [.one, .one, .zero, .one, .zero, .one, .one, .zero]
    
    // View Elements
    let mainContentStackView = UIStackView()
    let instructionTextView = FadingTextView()
    let numbersStackView = UIStackView()
    var numberViews: [BinaryNumberView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainContentStackView.axis = .vertical
        mainContentStackView.alignment = .fill
        mainContentStackView.distribution = .fill
        mainContentStackView.spacing = 10
        mainContentStackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mainContentStackView)
        NSLayoutConstraint.activate([
            mainContentStackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            mainContentStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            mainContentStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            mainContentStackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
            mainContentStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        
        instructionTextView.attributedText = createAttributedMarkdownString(instructionText)
        instructionTextView.isScrollEnabled = true
        instructionTextView.textColor = .label
        instructionTextView.backgroundColor = .clear
        instructionTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        instructionTextView.textContainerInset = .zero
        instructionTextView.translatesAutoresizingMaskIntoConstraints = false
        instructionTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
        mainContentStackView.addArrangedSubview(instructionTextView)
        
        numbersStackView.axis = .horizontal
        numbersStackView.distribution = .fillEqually
        numbersStackView.spacing = 10
        numbersStackView.translatesAutoresizingMaskIntoConstraints = false
        numbersStackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
        mainContentStackView.addArrangedSubview(numbersStackView)
        
        for index in 0..<binaryExampleNumber.count {
            let numberView = BinaryNumberView(value: binaryExampleNumber[index], subtitleText: "")
            numberView.tag = index
            numberView.heightAnchor.constraint(equalTo: numberView.widthAnchor, multiplier: 1.5).isActive = true
            numbersStackView.addArrangedSubview(numberView)
            numberViews.append(numberView)
            numberView.alpha = 0
        }
        
        var delay: TimeInterval = 0.75
        for view in numberViews.reversed() {
            UIView.animate(withDuration: 0.2, delay: delay, options: .curveEaseInOut) {
                view.alpha = 1
            }
            delay += 0.1
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            print("Changing subtitle text")
            for view in self.numberViews {
                view.subtitleText = "00"
            }
        }

        
    }
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        guard parent != nil else { return }
//        DispatchQueue.main.async {
//            self.navigationView?.isForwardEnabled = true
//        }
    }
    
}
