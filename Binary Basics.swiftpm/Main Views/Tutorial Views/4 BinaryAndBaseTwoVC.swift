//
//  WelcomeView.swift
//  Binary Basics
//
//  Created by Dylan McDonald on 2/22/25.
//

import UIKit

class BinaryAndBase2VC: BBViewController {

    let instructionText = "Chances are you've seen binary before. For example, here's the number **214** in binary:"
    let binaryExampleNumber = [1, 1, 0, 1, 0, 1, 1, 0]
    
    // View Elements
    let mainContentStackView = UIStackView()
    let instructionTextView = FadingTextView()
    let numbersStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainContentStackView.axis = .vertical
        mainContentStackView.alignment = .fill
        mainContentStackView.distribution = .fill
        mainContentStackView.spacing = 10
        mainContentStackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mainContentStackView)
        NSLayoutConstraint.activate([
            mainContentStackView.topAnchor.constraint(greaterThanOrEqualTo: self.view.topAnchor, constant: 0),
            mainContentStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            mainContentStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            mainContentStackView.bottomAnchor.constraint(lessThanOrEqualTo: self.view.bottomAnchor, constant: 0),
            mainContentStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        
        instructionTextView.attributedText = createAttributedMarkdownString(instructionText)
        instructionTextView.isScrollEnabled = true
        instructionTextView.textColor = .label
        instructionTextView.backgroundColor = .clear
        instructionTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        instructionTextView.textContainerInset = .zero
        instructionTextView.translatesAutoresizingMaskIntoConstraints = false

        
    }
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        guard parent != nil else { return }
//        DispatchQueue.main.async {
//            self.navigationView?.isForwardEnabled = true
//        }
    }
    
}
