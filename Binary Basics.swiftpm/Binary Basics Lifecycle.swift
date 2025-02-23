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
            NavigationItem(viewController: DecimalVsBinaryBasesVC(), mainTitle: "Decimal vs. Binary", navigationTitle: "Decimal vs. Binary")
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
