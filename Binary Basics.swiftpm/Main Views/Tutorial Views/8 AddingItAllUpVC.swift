//
//  AddingItAllUpVC.swift
//  Binary Basics
//
//  Dylan McDonald | Swift Student Challenge 2025
//

import UIKit

class AddingItAllUpVC: BBViewController {

    let instructionsText = "Now, it is easy to see how this binary number represents the decimal number **214**. Just add up all of the values:"
    let formulaText = "128 + 64 + 0 + 16 + 0 + 4 + 2 + 0 = 214"/*.replacingOccurrences(of: " ", with: "")*/
    let binaryExampleNumber: [BinaryValue] = [.one, .one, .zero, .one, .zero, .one, .one, .zero]
    
    // View Elements
    let numbersStackView = UIStackView()
    var numberViews: [BinaryNumberView] = []
    let instructionsScrollView = FadingScrollView()
    let textStackView = UIStackView()
    let instructionsLabel = UILabel()
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
        for view in self.numberViews {
            if view.value == .one {
                view.updateSubtitle("On")
            } else {
                view.updateSubtitle("Off")
            }
        }
        
        let values = ["2⁷ = 128", "2⁶ = 64", "0", "2⁴ = 16", "0", "2² = 4", "2¹ = 2", "0"]
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            for (index, view) in self.numberViews.enumerated() {
                view.updateSubtitle(values[index], forceLineNumber: 1)
            }
        }
        
        
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
        
        
        instructionsLabel.attributedText = createAttributedMarkdownString(instructionsText)
        instructionsLabel.textColor = .label
        instructionsLabel.numberOfLines = 0
        instructionsLabel.translatesAutoresizingMaskIntoConstraints = false
        textStackView.addArrangedSubview(instructionsLabel)
        
        formulaLabel.text = formulaText
        formulaLabel.numberOfLines = 1
        formulaLabel.minimumScaleFactor = 0.1
        formulaLabel.adjustsFontSizeToFitWidth = true
        formulaLabel.textAlignment = .center
        formulaLabel.font = UIFont.monospacedSystemFont(ofSize: 90, weight: .black)
        formulaLabel.translatesAutoresizingMaskIntoConstraints = false
        textStackView.addArrangedSubview(formulaLabel)

        
    }
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        guard parent != nil else { return }
    }
    
}
