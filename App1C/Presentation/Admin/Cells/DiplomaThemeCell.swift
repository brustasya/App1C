//
//  DiplomaThemeCell.swift
//  App1C
//
//  Created by Станислава on 08.05.2024.
//

import UIKit

class DiplomaThemeCell: UITableViewCell, ConfigurableViewProtocol {
    
    typealias ConfigurationModel = DiplomaThemeModel
    
    weak var delegate: SpeechSelectorDelegate?
    
    private lazy var nameLabel = UILabel()
    private lazy var themeLabel = UILabel()
    private lazy var contentBackgroundView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentBackgroundView.layer.cornerRadius = 20
        contentBackgroundView.backgroundColor = .white
        contentBackgroundView.layer.borderColor = UIColor.black.cgColor
        contentBackgroundView.layer.borderWidth = 1
        
        contentView.addSubview(contentBackgroundView)
        contentBackgroundView.addSubview(nameLabel)
        contentBackgroundView.addSubview(themeLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        themeLabel.translatesAutoresizingMaskIntoConstraints = false
        contentBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            contentBackgroundView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -10),
            contentBackgroundView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: contentBackgroundView.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: contentBackgroundView.leadingAnchor, constant: 15),
            themeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            themeLabel.leadingAnchor.constraint(equalTo: contentBackgroundView.leadingAnchor, constant: 15),
            themeLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentBackgroundView.trailingAnchor, constant: -15),
            contentBackgroundView.bottomAnchor.constraint(equalTo: themeLabel.bottomAnchor, constant: 15),
            contentView.bottomAnchor.constraint(equalTo: contentBackgroundView.bottomAnchor, constant: 8)
        ])
        
        nameLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        nameLabel.textColor = .black
        
        themeLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        themeLabel.textColor = .black
        themeLabel.numberOfLines = 0
    }
    
    func configure(with model: ConfigurationModel) {
        nameLabel.text = model.name
        themeLabel.text = model.theme
    }
   
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
    }
}
