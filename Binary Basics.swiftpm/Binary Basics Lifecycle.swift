//
//  Binary Basics Lifecycle.swift
//  Binary Basics
//
//  Dylan McDonald | Swift Student Challenge 2025
//

import SwiftUI
import UIKit

struct UIKitWrapperView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> BasicNavigationView {
        let navigationItems: [NavigationItem] = [
            NavigationItem(viewController: WelcomeVC(), mainTitle: "Welcome!👋", navigationTitle: "Welcome"),
            NavigationItem(viewController: IntroductionToBinaryVC(), mainTitle: "Introduction to Binary", navigationTitle: "Introduction"),
            NavigationItem(viewController: DecimalVsBinaryBasesVC(), mainTitle: "Decimal vs. Binary", navigationTitle: "Decimal vs. Binary"),
            NavigationItem(viewController: BinaryAndBase2VC(), mainTitle: "Binary and Base-2", navigationTitle: "Binary and Base-2"),
            NavigationItem(viewController: BinaryPositionsVC(), mainTitle: "Binary and Base-2: Positions", navigationTitle: "Positions"),
            NavigationItem(viewController: BitValuesVC(), mainTitle: "Binary and Base-2: Bit Values", navigationTitle: "Bit Values"),
            NavigationItem(viewController: OnOrOffVC(), mainTitle: "Binary and Base-2: On or Off?", navigationTitle: "On or Off"),
            NavigationItem(viewController: AddingItAllUpVC(), mainTitle: "Binary and Base-2: Adding it All Up", navigationTitle: "Adding it All Up"),
            NavigationItem(viewController: ConversionTesterVC(), mainTitle: "Congratulations!", navigationTitle: ""),
        ]
            
        let toReturn = BasicNavigationView(navigationItems: navigationItems)
        toReturn.overrideUserInterfaceStyle = .dark
        return toReturn
    }
    
    func updateUIViewController(_ uiViewController: BasicNavigationView, context: Context) {
        
    }
}

@main
struct BinaryBasics: App {
    var body: some Scene {
        WindowGroup {
            UIKitWrapperView()
                .preferredColorScheme(.dark)
                .ignoresSafeArea()
        }
    }
}
