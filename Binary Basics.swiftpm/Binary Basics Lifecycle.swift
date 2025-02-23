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
        let navigationItem = NavigationItem(viewController: WelcomeView(), mainTitle: "Welcome!👋", navigationTitle: "Welcome")
        return BasicNavigationView(navigationItems: [navigationItem, navigationItem, navigationItem])
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
