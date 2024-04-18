//
//  LinkView.swift
//  App1C
//
//  Created by Станислава on 03.04.2024.
//

import UIKit

final class LinkView: UIView {
    private let contentView: UIView
    private let titleText: String
    private let image: UIImage?
    private let imageSize: CGSize
    
    init(
        contentView: UIView,
        frame: CGRect,
        title: String,
        image: UIImage?,
        imageSize: CGSize
    ) {
        self.contentView = contentView
        self.titleText = title
        self.image = image
        self.imageSize = imageSize
        
        super.init(frame: frame)

        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 15
        backgroundColor = Colors.paleYellow.uiColor
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        let title = UILabel()
        title.textColor = .darkGray
        title.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        
        addSubview(imageView)
        addSubview(title)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = titleText
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 100),
            widthAnchor.constraint(equalToConstant: 100),
            topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 25),
            
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10),
            imageView.heightAnchor.constraint(equalToConstant: imageSize.height),
            
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
            title.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}
