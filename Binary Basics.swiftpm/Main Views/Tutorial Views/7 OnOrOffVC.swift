//
//  OnOrOffVC.swift
//  Binary Basics
//
//  Dylan McDonald | Swift Student Challenge 2025
//

import UIKit

class OnOrOffVC: BBViewController {

    let instructionText = "But, remember how each bit represents **\"on\"** or **\"off\"**? Well, a bit **only has a value if the bit is a 1 (on)**. If the bit is a **0 (off)**, it has **no value**. Now, let's see how this works with our example number..."
    let binaryExampleNumber: [BinaryValue] = [.one, .one, .zero, .one, .zero, .one, .one, .zero]
    
    // View Elements
    let numbersStackView = UIStackView()
    var numberViews: [BinaryNumberView] = []
    let instructionTextView = FadingTextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numbersStackView.axis = .horizontal
        numbersStackView.distribution = .fillEqually
        numbersStackView.spacing = 10
        numbersStackView.translatesAutoresizingMaskIntoConstraints = false
        numbersStackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
        self.view.addSubview(numbersStackView)
        NSLayoutConstraint.activate([
            numbersStackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            numbersStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            numbersStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
        ])
        
        for index in 0..<binaryExampleNumber.count {
            let numberView = BinaryNumberView(value: binaryExampleNumber[index], subtitleText: "", index: index)
            numberView.tag = index
            numberView.heightAnchor.constraint(equalTo: numberView.widthAnchor, multiplier: 1.5).isActive = true
            numbersStackView.addArrangedSubview(numberView)
            numberViews.append(numberView)
        }
        for (index, view) in self.numberViews.reversed().enumerated() {
            view.updateSubtitle("Pos: \(index)", animated: false)
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            for view in self.numberViews {
                if view.value == .one {
                    view.updateSubtitle("On")
                } else {
                    view.updateSubtitle("Off")
                }
            }
        }
        
        
        instructionTextView.attributedText = createAttributedMarkdownString(instructionText)
        instructionTextView.isScrollEnabled = true
        instructionTextView.textColor = .label
        instructionTextView.backgroundColor = .clear
        instructionTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        instructionTextView.textContainerInset = .zero
        instructionTextView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(instructionTextView)
        NSLayoutConstraint.activate([
            instructionTextView.topAnchor.constraint(equalTo: numbersStackView.bottomAnchor, constant: 20),
            instructionTextView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            instructionTextView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            instructionTextView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        ])

        
    }
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        guard parent != nil else { return }
    }
    
}
