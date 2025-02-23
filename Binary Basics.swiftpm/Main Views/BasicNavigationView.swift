import UIKit
import CoreMotion

// A simple container for a view controller and its title.
struct NavigationItem {
    let viewController: BBViewController
    let mainTitle: String
    let navigationTitle: String
}

class BasicNavigationView: UIViewController {
    
    // Public Variables
    var accentColor: UIColor = .currentColor {
        didSet {
            gradientLayer?.colors = [accentColor.withBrightnessAdjustment(0.65).cgColor, accentColor.withBrightnessAdjustment(0.35).cgColor]
        }
    }
    var titleString: String = "" {
        didSet {
            titleLabel.text = titleString
        }
    }
    var isForwardEnabled: Bool = true {
        didSet {
            forwardButton.isUserInteractionEnabled = isForwardEnabled
            UIView.animate(withDuration: 0.3) {
                self.forwardButton.alpha = self.isForwardEnabled ? 1 : 0.5
            }
        }
    }
    var isBackEnabled: Bool = true {
        didSet {
            backButton.isUserInteractionEnabled = isBackEnabled
            UIView.animate(withDuration: 0.3) {
                self.backButton.alpha = self.isBackEnabled ? 1 : 0.5
            }
        }
    }
    
    // Private navigation stack
    private var navigationItems: [NavigationItem] = []
    private var currentIndex: Int = 0
    
    // View Elements
    private var gradientLayer: CAGradientLayer?
    private var rootViewContainer = UIView()
    private var titleLabel = UILabel()
    private var backButton = UIButton()
    private var forwardButton = UIButton()
    private var closeButton = UIButton()
    
    // Flag for whether the close button should be shown
    private var showCloseButton: Bool = false
    
    // MARK: - Initializers
    init(navigationItems: [NavigationItem], showCloseButton: Bool = false) {
        self.navigationItems = navigationItems
        self.showCloseButton = showCloseButton
        if let first = navigationItems.first {
            self.titleString = first.mainTitle
        }
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientBackground()
        setupView()
        updateNavigation(animate: false)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer?.frame = view.bounds
    }
    
    // MARK: - Navigation Actions
    private func goBack() {
        if currentIndex > 0 && isBackEnabled{
            currentIndex -= 1
            updateNavigation()
        }
    }
    
    private func goForward() {
        if currentIndex < navigationItems.count - 1 && isForwardEnabled {
            currentIndex += 1
            updateNavigation()
        }
    }
    
    // Update the displayed view controller, the title, and the navigation buttons.
    private func updateNavigation(animate: Bool = true) {
        let currentItem = navigationItems[currentIndex]
        titleString = currentItem.mainTitle
        
        if currentIndex > 0 {
            let prevTitle = navigationItems[currentIndex - 1].navigationTitle
            backButton.setTitle(prevTitle, for: .normal)
            if backButton.alpha != 1 {
                UIView.animate(withDuration: 0.3) {
                    self.backButton.alpha = 1
                }
            }
        } else {
            backButton.setTitle("Back", for: .normal)
            if backButton.alpha != 0 {
                UIView.animate(withDuration: 0.3) {
                    self.backButton.alpha = 0
                }
            }
        }
        
        if currentIndex < navigationItems.count - 1 {
            let nextTitle = navigationItems[currentIndex + 1].navigationTitle
            forwardButton.setTitle(nextTitle, for: .normal)
            if forwardButton.alpha != 1 {
                UIView.animate(withDuration: 0.3) {
                    self.forwardButton.alpha = 1
                }
            }
        } else {
            forwardButton.setTitle("Forward", for: .normal)
            if forwardButton.alpha != 0 {
                UIView.animate(withDuration: 0.3) {
                    self.forwardButton.alpha = 0
                }
            }
        }
        
        let oldVC = children.first
        let newVC = currentItem.viewController
        
        addChild(newVC)
        newVC.navigationView = self
        newVC.view.translatesAutoresizingMaskIntoConstraints = false
        rootViewContainer.addSubview(newVC.view)
        NSLayoutConstraint.activate([
            newVC.view.topAnchor.constraint(greaterThanOrEqualTo: rootViewContainer.topAnchor, constant: 0),
            newVC.view.bottomAnchor.constraint(lessThanOrEqualTo: rootViewContainer.bottomAnchor, constant: 0),
            newVC.view.leadingAnchor.constraint(equalTo: rootViewContainer.leadingAnchor),
            newVC.view.trailingAnchor.constraint(equalTo: rootViewContainer.trailingAnchor),
            newVC.view.centerXAnchor.constraint(equalTo: rootViewContainer.centerXAnchor),
            newVC.view.centerYAnchor.constraint(equalTo: rootViewContainer.centerYAnchor)
        ])
        newVC.didMove(toParent: self)
        
        
        if animate, let oldVC = oldVC {
            newVC.view.alpha = 0
            UIView.animate(withDuration: 0.3, animations: {
                oldVC.view.alpha = 0
                newVC.view.alpha = 1
            }, completion: { _ in
                oldVC.willMove(toParent: nil)
                oldVC.view.removeFromSuperview()
                oldVC.removeFromParent()
            })
        } else {
            oldVC?.willMove(toParent: nil)
            oldVC?.view.removeFromSuperview()
            oldVC?.removeFromParent()
        }
    }
}

extension BasicNavigationView {
    func setupView() {
        // Title Label setup
        titleLabel.font = UIFont.monospacedSystemFont(ofSize: 55, weight: .bold)
        titleLabel.textColor = .label
        titleLabel.text = titleString
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50)
        ])
        
        // Back Button
        backButton = navigationButton(title: "Back", iconName: "chevron.backward", action: UIAction { _ in
            self.goBack()
        })
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            backButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
        
        // Forward Button
        forwardButton = navigationButton(title: "Forward", iconName: "chevron.forward", iconPlacement: .trailing, action: UIAction { _ in
            self.goForward()
        })
        forwardButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(forwardButton)
        NSLayoutConstraint.activate([
            forwardButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            forwardButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
        
        // Close Button
        closeButton = navigationButton(title: "Close", iconName: "xmark", action: UIAction { _ in
            self.dismiss(animated: true, completion: nil)
        })
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: closeButton.leadingAnchor, constant: -10),
            closeButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor)
        ])
        closeButton.isHidden = !showCloseButton
        
        // Container for the current view controller's view
        rootViewContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rootViewContainer)
        NSLayoutConstraint.activate([
            rootViewContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25),
            rootViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            rootViewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            rootViewContainer.bottomAnchor.constraint(equalTo: backButton.topAnchor, constant: -25)
        ])
    }
    
}

// Gradient background setup
extension BasicNavigationView {
    private func setupGradientBackground() {
        let lighterColor = accentColor.withBrightnessAdjustment(0.65)
        let darkerColor = accentColor.withBrightnessAdjustment(0.35)
        
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [lighterColor.cgColor, darkerColor.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        view.layer.insertSublayer(gradient, at: 0)
        self.gradientLayer = gradient
    }
}
