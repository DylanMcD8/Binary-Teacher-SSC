//
//  IntroductionToBinaryVC.swift
//  Binary Basics
//
//  Dylan McDonald | Swift Student Challenge 2025
//

import UIKit

class IntroductionToBinaryVC: BBViewController {

    let instructionOne = "Binary consists of only two digits, which are called bits:"
    let numbers = "0 and 1"
    let instructionTwo = "Binary is the way that computers store and process data. You can think of these as 0 = off and 1 = on. Today we'll learn how to represent numbers in binary."
    
    // View Elements
    let instructionOneLabel = UILabel()
    let numbersLabel = UILabel()
    let instructionTwoLabel = UILabel()
    let textStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.navigationView?.isForwardEnabled = true
        }
        textStackView.axis = .vertical
        textStackView.alignment = .fill
        textStackView.distribution = .fill
        textStackView.spacing = 10
        textStackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(textStackView)
        NSLayoutConstraint.activate([
            textStackView.topAnchor.constraint(greaterThanOrEqualTo: self.view.topAnchor, constant: 0),
            textStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            textStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            textStackView.bottomAnchor.constraint(lessThanOrEqualTo: self.view.bottomAnchor, constant: 0),
            textStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        
        instructionOneLabel.text = instructionOne
        instructionOneLabel.numberOfLines = 0
        instructionOneLabel.minimumScaleFactor = 0.5
        instructionOneLabel.font = UIFont.monospacedSystemFont(ofSize: 40, weight: .semibold)
        instructionOneLabel.translatesAutoresizingMaskIntoConstraints = false
        textStackView.addArrangedSubview(instructionOneLabel)
        
        numbersLabel.text = numbers
        numbersLabel.numberOfLines = 1
        numbersLabel.minimumScaleFactor = 0.5
        numbersLabel.textAlignment = .center
        numbersLabel.font = UIFont.monospacedSystemFont(ofSize: 90, weight: .black)
        numbersLabel.translatesAutoresizingMaskIntoConstraints = false
        textStackView.addArrangedSubview(numbersLabel)
        
        instructionTwoLabel.text = instructionTwo
        instructionTwoLabel.numberOfLines = 0
        instructionTwoLabel.minimumScaleFactor = 0.5
        instructionTwoLabel.font = UIFont.monospacedSystemFont(ofSize: 40, weight: .semibold)
        instructionTwoLabel.translatesAutoresizingMaskIntoConstraints = false
        textStackView.addArrangedSubview(instructionTwoLabel)
        
    }
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        guard parent != nil else { return }
    }
    
}
