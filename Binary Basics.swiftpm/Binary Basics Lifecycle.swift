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
        let navigationItem1 = NavigationItem(viewController: WelcomeView(), mainTitle: "Welcome!👋", navigationTitle: "Welcome")
        let navigationItem2 = NavigationItem(viewController: WelcomeView2(), mainTitle: "New Title", navigationTitle: "New Title")
        return BasicNavigationView(navigationItems: [navigationItem1, navigationItem2, navigationItem1])
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
