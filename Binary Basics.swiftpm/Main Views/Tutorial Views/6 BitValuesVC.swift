//
//  BitValuesVC.swift
//  Binary Basics
//
//  Dylan McDonald | Swift Student Challenge 2025
//

import UIKit

class BitValuesVC: BBViewController {

    let instructionOneText = "Okay great, now each bit has a position! This means that we can now assign a value to each bit:"
    let formulaText = "2ᵖᵒˢ"
    let instructionTwoText = "Each bit is worth **2 to the power of its position**. This means our 0th bit is worth 2⁰ = 1, our 1st bit is worth 2¹ = 2, and so on."
    let binaryExampleNumber: [BinaryValue] = [.one, .one, .zero, .one, .zero, .one, .one, .zero]
    
    // View Elements
    let numbersStackView = UIStackView()
    var numberViews: [BinaryNumberView] = []
    let instructionsScrollView = FadingScrollView()
    let textStackView = UIStackView()
    let instructionsOneLabel = UILabel()
    let formulaLabel = UILabel()
    let instructionsTwoLabel = UILabel()
    
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
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
//            for (index, view) in self.numberViews.reversed().enumerated() {
//                view.subtitleText = "Pos: \(index)"
//            }
//        }
        
        
        instructionsScrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(instructionsScrollView)
        NSLayoutConstraint.activate([
            instructionsScrollView.topAnchor.constraint(equalTo: numbersStackView.bottomAnchor, constant: 20),
            instructionsScrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            instructionsScrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            instructionsScrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        ])
        
        textStackView.axis = .vertical
        textStackView.alignment = .fill
        textStackView.distribution = .fill
        textStackView.spacing = 10
        textStackView.translatesAutoresizingMaskIntoConstraints = false
        instructionsScrollView.addSubview(textStackView)
        NSLayoutConstraint.activate([
            textStackView.topAnchor.constraint(equalTo: instructionsScrollView.contentLayoutGuide.topAnchor),
            textStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            textStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            textStackView.bottomAnchor.constraint(equalTo: instructionsScrollView.contentLayoutGuide.bottomAnchor)
        ])
        
        
        instructionsOneLabel.attributedText = createAttributedMarkdownString(instructionOneText)
        instructionsOneLabel.textColor = .label
        instructionsOneLabel.numberOfLines = 0
        instructionsOneLabel.translatesAutoresizingMaskIntoConstraints = false
        textStackView.addArrangedSubview(instructionsOneLabel)
        
        formulaLabel.text = formulaText
        formulaLabel.numberOfLines = 1
        formulaLabel.minimumScaleFactor = 0.5
        formulaLabel.textAlignment = .center
        formulaLabel.font = UIFont.monospacedSystemFont(ofSize: 90, weight: .black)
        formulaLabel.translatesAutoresizingMaskIntoConstraints = false
        textStackView.addArrangedSubview(formulaLabel)
        
        instructionsTwoLabel.attributedText = createAttributedMarkdownString(instructionTwoText)
        instructionsTwoLabel.textColor = .label
        instructionsTwoLabel.numberOfLines = 0
        instructionsTwoLabel.translatesAutoresizingMaskIntoConstraints = false
        textStackView.addArrangedSubview(instructionsTwoLabel)

        
    }
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        guard parent != nil else { return }
    }
    
}
