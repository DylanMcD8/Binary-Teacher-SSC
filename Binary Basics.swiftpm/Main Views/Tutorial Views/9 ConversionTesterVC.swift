//
//  ConversionTesterVC.swift
//  Binary Basics
//
//  Dylan McDonald | Swift Student Challenge 2025
//

import UIKit

class ConversionTesterVC: BBViewController, BinaryNumberHostViewController {
    
    var presentingFromTutorial: Bool = true

    var instructionText = ""
    var currentDecimal: Int = 0
    var currentBinary: [Int] = [0, 0, 0, 0, 0, 0, 0, 0]
    
    // View Elements
    let instructionTextView = FadingTextView()
    let numbersStackView = UIStackView()
    var numberViews: [BinaryNumberView] = []
    let decimalLabel = UILabel()
    
    init(presentingFromTutorial: Bool) {
        super.init(nibName: nil, bundle: nil)
        self.presentingFromTutorial = presentingFromTutorial
        instructionText = (presentingFromTutorial ? "You've learned the basics of binary! " : "") + "On this page, you can experiment with creating different binary numbers on this page to test your knowledge of binary to decimal conversion. Try creating different numbers and see how they convert to decimal! Just tap each bit to toggle it between **0** and **1**. Tap the Close button when you're done."
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        instructionTextView.attributedText = createAttributedMarkdownString(instructionText)
        instructionTextView.isScrollEnabled = true
        instructionTextView.textColor = .label
        instructionTextView.backgroundColor = .clear
        instructionTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        instructionTextView.textContainerInset = .zero
        instructionTextView.translatesAutoresizingMaskIntoConstraints = false
//        instructionTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
        self.view.addSubview(instructionTextView)
        NSLayoutConstraint.activate([
            instructionTextView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            instructionTextView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            instructionTextView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
        ])
        
        numbersStackView.axis = .horizontal
        numbersStackView.distribution = .fillEqually
        numbersStackView.spacing = 10
        numbersStackView.translatesAutoresizingMaskIntoConstraints = false
        numbersStackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
        self.view.addSubview(numbersStackView)
        NSLayoutConstraint.activate([
            numbersStackView.topAnchor.constraint(equalTo: instructionTextView.bottomAnchor, constant: 20),
            numbersStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            numbersStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
        ])
        
        for index in 0...7 {
            let numberView = BinaryNumberView(value: .zero, subtitleText: "", index: index, isEditable: true, sourceView: self)
            numberView.tag = index
            numberView.heightAnchor.constraint(equalTo: numberView.widthAnchor, multiplier: 1.5).isActive = true
            numbersStackView.addArrangedSubview(numberView)
            numberViews.append(numberView)
//            numberView.alpha = 0
        }
        
        
        decimalLabel.text = "Decimal: 0"
        decimalLabel.setContentHuggingPriority(.required, for: .vertical)
        decimalLabel.font = UIFont.monospacedSystemFont(ofSize: 40, weight: .semibold)
        decimalLabel.textAlignment = .center
        decimalLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(decimalLabel)
        NSLayoutConstraint.activate([
            decimalLabel.topAnchor.constraint(equalTo: numbersStackView.bottomAnchor, constant: 10),
            decimalLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            decimalLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            decimalLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        ])

        
    }
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        if parent == nil {
            DispatchQueue.main.async {
                self.navigationView?.showCloseButton = false
            }
        } else {
            DispatchQueue.main.async {
                self.navigationView?.showCloseButton = true
            }
        }
    }
    
    func updateBinaryNumber(forIndex index: Int, withValue value: Int) {
        currentBinary[index] = value
        updateDecimalLabel()
    }
    
    func updateDecimalLabel() {
        print("Updating Decimal Label")
        currentDecimal = binaryToDecimal(currentBinary)
        decimalLabel.text = "Decimal: \(currentDecimal)"
    }
    
}
