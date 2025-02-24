//
//  BinaryBasicsHomeVC.swift
//  Binary Basics
//
//  Dylan McDonald | Swift Student Challenge 2025
//

import UIKit

class BinaryBasicsHomeVC: UIViewController {
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    // Public Variables
    var accentColor: UIColor = .currentColor {
        didSet {
            gradientLayer?.colors = [accentColor.withBrightnessAdjustment(0.65).cgColor, accentColor.withBrightnessAdjustment(0.35).cgColor]
        }
    }

    // View Elements
    private var gradientLayer: CAGradientLayer?
    private var titleLabel = UILabel()
    private var tilesContainerView = UIView()
    private var colorsStackView = UIStackView()
    // Tiles
    private var learnBinaryTile = UIView()
    private var binaryExplorerTile = UIView()
//    private var aboutMeTile = UIView()
    private var tilesStackView = UIStackView()
    
    
    // MARK: - Initializers
//    init(navigationItems: [NavigationItem], showCloseButton: Bool = false) {
//        self.navigationItems = navigationItems
//        self.showCloseButton = showCloseButton
//        if let first = navigationItems.first {
//            self.titleString = first.mainTitle
//        }
//        super.init(nibName: nil, bundle: nil)
//    }
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientBackground()
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer?.frame = view.bounds
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        if size.width < size.height {
            UIView.animate(withDuration: 0.3) {
                self.tilesStackView.axis = .vertical
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.tilesStackView.axis = .horizontal
            }
        }
    }
    
    // MARK: - Actions
    @objc func learnBinaryTapped() {
        let vc = tutorialViews()
        vc.preferredTransition = .zoom { context in
            return self.learnBinaryTile
        }
        vc.isModalInPresentation = true
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    @objc func binaryExplorerTapped() {
        let vc = ConversionTesterVC(presentingFromTutorial: false)
        let nav = BasicNavigationView(navigationItems: [NavigationItem(viewController: vc, mainTitle: "Binary Explorer", navigationTitle: "")], showCloseButton: true)
        nav.preferredTransition = .zoom { context in
            return self.binaryExplorerTile
        }
        nav.modalPresentationStyle = .overFullScreen
        present(nav, animated: true)
    }
    
//    @objc func aboutMeTapped() {
////        let vc = AboutMeVC()
////        vc.preferredTransition = .zoom { context in
////            return self.aboutMeTile
////        }
////        vc.modalPresentationStyle = .overFullScreen
////        present(vc, animated: true)
//    }

}

extension BinaryBasicsHomeVC {
    func setupView() {
        // Title Label setup
        titleLabel.font = UIFont.monospacedSystemFont(ofSize: 55, weight: .bold)
        titleLabel.textColor = .label
        titleLabel.text = "Binary Basics"
        titleLabel.minimumScaleFactor = 0.5
        titleLabel.numberOfLines = 1
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50)
        ])
        
        // Tiles container view
        tilesContainerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tilesContainerView)
        NSLayoutConstraint.activate([
            tilesContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            tilesContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            tilesContainerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25)
        ])
        
        tilesStackView.axis = .horizontal
        tilesStackView.distribution = .fillEqually
        tilesStackView.spacing = 25
        tilesStackView.translatesAutoresizingMaskIntoConstraints = false
        tilesContainerView.addSubview(tilesStackView)
        NSLayoutConstraint.activate([
            tilesStackView.topAnchor.constraint(equalTo: tilesContainerView.topAnchor),
            tilesStackView.leadingAnchor.constraint(equalTo: tilesContainerView.leadingAnchor),
            tilesStackView.trailingAnchor.constraint(equalTo: tilesContainerView.trailingAnchor),
            tilesStackView.bottomAnchor.constraint(equalTo: tilesContainerView.bottomAnchor)
        ])
        
        // Tiles
        learnBinaryTile = HomeTileUIView(title: "Learn Binary", icon: UIImage(named: "BB Icon SVG") ?? UIImage(systemName: "apple.terminal")!, subtitle: "Start Here!")
        binaryExplorerTile = HomeTileUIView(title: "Binary Explorer", icon: UIImage(named: "Binary Explorer SVG") ?? UIImage(systemName: "0.square.fill")!, subtitle: "")
//        aboutMeTile = HomeTileUIView(title: "About Me", icon: UIImage(named: "Wave SVG") ?? UIImage(systemName: "hand.wave")!)
        
        tilesStackView.addArrangedSubview(learnBinaryTile)
        tilesStackView.addArrangedSubview(binaryExplorerTile)
//        tilesStackView.addArrangedSubview(aboutMeTile)
        
        // tap gestures
        let learnBinaryTap = UITapGestureRecognizer(target: self, action: #selector(learnBinaryTapped))
        learnBinaryTile.addGestureRecognizer(learnBinaryTap)
        
        let binaryExplorerTap = UITapGestureRecognizer(target: self, action: #selector(binaryExplorerTapped))
        binaryExplorerTile.addGestureRecognizer(binaryExplorerTap)
        
//        let aboutMeTap = UITapGestureRecognizer(target: self, action: #selector(aboutMeTapped))
//        aboutMeTile.addGestureRecognizer(aboutMeTap)
        
        
        
        // Color picker
        colorsStackView.axis = .horizontal
        colorsStackView.distribution = .fillEqually
        colorsStackView.spacing = 15
        colorsStackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(colorsStackView)
        NSLayoutConstraint.activate([
            colorsStackView.topAnchor.constraint(equalTo: tilesContainerView.bottomAnchor, constant: 25),
            colorsStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            colorsStackView.leadingAnchor.constraint(greaterThanOrEqualTo: self.view.leadingAnchor, constant: 50),
            colorsStackView.trailingAnchor.constraint(lessThanOrEqualTo: self.view.trailingAnchor, constant: -50),
            colorsStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            colorsStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        let colors: [AppleColors] = [.green, .yellow, .orange, .red, .purple, .blue]
        var buttons: [UIButton] = []
        for color in colors {
            let button = UIButton()
            button.setTitle(color.rawValue, for: .normal)
            button.setTitleColor(.label, for: .normal)
            button.backgroundColor = convertAppleColorToUIColor(color)
            button.heightAnchor.constraint(equalToConstant: 50).isActive = true
            button.widthAnchor.constraint(equalToConstant: 50).isActive = true
            button.layer.cornerRadius = 50 / 2
            button.translatesAutoresizingMaskIntoConstraints = false
            button.layer.borderColor = UIColor.white.withAlphaComponent(0.3).cgColor
            let isCurrentColor = UserSettings.accentColor == color
            button.layer.borderWidth = isCurrentColor ? 26 : 3
            button.tag = colors.firstIndex(of: color) ?? 0
            colorsStackView.addArrangedSubview(button)
            buttons.append(button)
            
            let action = UIAction { _ in
                for button in buttons {
                    UIView.animate(withDuration: 0.3) {
                        let buttonIsSelf = button.tag == colors.firstIndex(of: color) ?? 0
                        button.layer.borderWidth = buttonIsSelf ? 26 : 3
                    }
                }
                
                UserSettings.accentColor = color
                self.accentColor = .currentColor
            }
            button.addAction(action, for: .touchUpInside)
            
            
            button.configurationUpdateHandler = { button in
                if button.isHighlighted {
                    UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseInOut) {
                        button.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                        button.alpha = 0.65
                    }
                } else {
                    UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseInOut) {
                        button.transform = .identity
                        button.alpha = 1
                    }
                }
            }
            
        }
    }
    
}

// Gradient background setup
extension BinaryBasicsHomeVC {
    private func setupGradientBackground() {
        let lighterColor = accentColor.withBrightnessAdjustment(0.65)
        let darkerColor = accentColor.withBrightnessAdjustment(0.35)
        
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [lighterColor.cgColor, darkerColor.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.masksToBounds = false
        view.layer.insertSublayer(gradient, at: 0)
        self.gradientLayer = gradient
    }
}
