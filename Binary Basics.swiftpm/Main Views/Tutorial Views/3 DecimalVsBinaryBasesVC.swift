//
//  WelcomeView.swift
//  Binary Basics
//
//  Created by Dylan McDonald on 2/22/25.
//

import UIKit

class DecimalVsBinaryBasesVC: BBViewController {

    let instructionText = "In everyday life, we use the **decimal** system, which is **Base-10**. This means that for every digit in a number, there are ten possible options: **0-9**. Once you go above 9, you add a digit and move to the next position. For example, 99 is two digits. If you add 1, the answer is 100, which is three digits.\n\nIn **binary**, however, **Base-2** is used. This is why there are only two options: **0 and 1**."
    
    // View Elements
    let instructionTextView = FadingTextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        instructionTextView.attributedText = createAttributedMarkdownString(instructionText)
        instructionTextView.isScrollEnabled = true
        instructionTextView.textColor = .label
        instructionTextView.backgroundColor = .clear
        instructionTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        instructionTextView.textContainerInset = .zero
        instructionTextView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(instructionTextView)
        NSLayoutConstraint.activate([
            instructionTextView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            instructionTextView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            instructionTextView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            instructionTextView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        ])
        
    }
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
    }
    
}
