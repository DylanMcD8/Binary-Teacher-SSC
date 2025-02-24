//
//  ColorfulUIView.swift
//  Binary Basics
//
//  Dylan McDonald | Swift Student Challenge 2025
//

import UIKit

class HomeTileUIView: UIView, UIPointerInteractionDelegate, UIGestureRecognizerDelegate {
    private var addHighlight: Bool = false
    
    private var regularColor: UIColor {
        return .white.withAlphaComponent(0.2)
    }
    private var selectedColor: UIColor {
        return .white.withAlphaComponent(0.35)
    }
    private var outlineColor: CGColor {
        return UIColor.white.withAlphaComponent(0.2).cgColor
    }
    
    private var titleLabel = UILabel()
    private var titleString: String = ""
    private var iconImageView = UIImageView()
    private var iconImage: UIImage!
    private var subtitleLabel = UILabel()
    private var subtitleString: String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    init(frame: CGRect = .zero, title: String, icon: UIImage, subtitle: String, addHighlight: Bool = false) {
        self.titleString = title
        self.iconImage = icon
        self.addHighlight = addHighlight
        self.subtitleString = subtitle
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        setColors()
        self.layer.cornerRadius = 30
        self.layer.cornerCurve = .continuous
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateThemeColor(_:)), name: NSNotification.Name(rawValue: "updatethemecolor"), object: nil)
        
        if addHighlight {
            setupPointerInteraction()
            setupTapGesture()
        }
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -20),
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .white.withAlphaComponent(0.75)
        stackView.addArrangedSubview(iconImageView)
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: 75),
            iconImageView.heightAnchor.constraint(equalToConstant: 75)
        ])
        
        titleLabel.font = UIFont.monospacedSystemFont(ofSize: 35, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.minimumScaleFactor = 0.5
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(titleLabel)
        
        if subtitleString != "" {
            subtitleLabel.font = UIFont.monospacedSystemFont(ofSize: 25, weight: .semibold)
            subtitleLabel.textAlignment = .center
            subtitleLabel.numberOfLines = 0
            subtitleLabel.minimumScaleFactor = 0.5
            subtitleLabel.adjustsFontSizeToFitWidth = true
            subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(subtitleLabel)
        }
        
        iconImageView.image = iconImage
        titleLabel.text = titleString
        subtitleLabel.text = subtitleString
        
    }
    
    private func setColors() {
        self.backgroundColor = regularColor
        self.tintColor = .currentColor
        self.layer.borderColor = outlineColor
        self.layer.borderWidth = 5
    }
    
    private func setupPointerInteraction() {
        let pointerInteraction = UIPointerInteraction(delegate: self)
        self.addInteraction(pointerInteraction)
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tapGesture.delegate = self  // Set delegate to allow multiple gestures
        self.addGestureRecognizer(tapGesture)
        self.isUserInteractionEnabled = true  // Ensure interaction is enabled
    }
    
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        self.backgroundColor = selectedColor
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            UIView.animate(withDuration: 0.3) {
                self.backgroundColor = self.regularColor
            }
        }
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func pointerInteraction(_ interaction: UIPointerInteraction, styleFor region: UIPointerRegion) -> UIPointerStyle? {
        let targetedPreview = UITargetedPreview(view: self)
        return UIPointerStyle(effect: .highlight(targetedPreview))
    }
    
    @objc func updateThemeColor(_ notification: Notification) {
        setColors()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
