//
//  CustomNavigationController.swift
//  App1C
//
//  Created by Станислава on 03.04.2024.
//

import UIKit

class CustomNavigationController: UINavigationController {

    lazy var bellButton = UIButton(type: .system)
    lazy var backButton =  UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.backgroundColor = Colors.yellow.uiColor
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = Colors.yellow.uiColor

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let statusBarHeight = windowScene.statusBarManager?.statusBarFrame.height ?? 0
            let statusBarView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: statusBarHeight))
            statusBarView.backgroundColor = Colors.yellow.uiColor
            view.addSubview(statusBarView)
        }
        
       // setupBackButton()
        setupImage()
        setupSeparator()
    }
    
    private func setupSeparator() {
        let separator = UIView()
        navigationBar.addSubview(separator)
        separator.translatesAutoresizingMaskIntoConstraints = false
        
        separator.backgroundColor = .systemGray4
        
        NSLayoutConstraint.activate([
            separator.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            separator.heightAnchor.constraint(equalToConstant: 0.5),
            separator.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor)
        ])
    }
    
    private func setupImage() {
        if let image = Images.logo.uiImage {
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            
            navigationBar.addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                imageView.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor),
                imageView.centerXAnchor.constraint(equalTo: navigationBar.centerXAnchor),
                imageView.heightAnchor.constraint(equalToConstant: 45)
            ])
        }
    }
    
    func setupBellButton() {
        navigationBar.addSubview(bellButton)
        bellButton.translatesAutoresizingMaskIntoConstraints = false
        
        bellButton.setImage(Images.bell.uiImage, for: .normal)
        bellButton.tintColor = .darkGray
        
        NSLayoutConstraint.activate([
            bellButton.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor),
            bellButton.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor, constant: -20),
            bellButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        bellButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
    }
    
    func setupBellBadgeButton() {
        let bellButton = UIButton(type: .system)
        navigationBar.addSubview(bellButton)
        bellButton.translatesAutoresizingMaskIntoConstraints = false
        
        bellButton.setImage(Images.bellBadge.uiImage, for: .normal)
        bellButton.tintColor = .darkGray
        
        let badgeImageView = UIImageView()
        badgeImageView.backgroundColor = Colors.red.uiColor
        badgeImageView.layer.cornerRadius = 4
        bellButton.addSubview(badgeImageView)
        badgeImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bellButton.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor),
            bellButton.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor, constant: -20),
            bellButton.heightAnchor.constraint(equalToConstant: 50),
            
            badgeImageView.heightAnchor.constraint(equalToConstant: 8),
            badgeImageView.widthAnchor.constraint(equalToConstant: 8),
            badgeImageView.topAnchor.constraint(equalTo: bellButton.topAnchor, constant: 13.5),
            badgeImageView.trailingAnchor.constraint(equalTo: bellButton.trailingAnchor, constant: -3.5)
        ])
        
        bellButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
    }
    
    func setupBackButton() {
        backButton = UIButton(type: .system)
        navigationBar.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        backButton.setImage(Images.back.uiImage, for: .normal)
        backButton.tintColor = .darkGray
        
        NSLayoutConstraint.activate([
            backButton.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor),
            backButton.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor, constant: 20),
            backButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        backButton.isHidden = false
    }
    
    func hideBackButton() {
        backButton.isHidden = true
    }
    
    @objc func goBack() { }
    
    @objc func bellButtonTapped() { }
}

