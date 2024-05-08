//
//  SpeechCell.swift
//  App1C
//
//  Created by Станислава on 08.05.2024.
//

import UIKit

class SpeechCell: UITableViewCell, ConfigurableViewProtocol {
    
    typealias ConfigurationModel = SpeechModel
        
    private lazy var titleLabel = UILabel()
    private lazy var rightImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(rightImageView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        rightImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            rightImageView.heightAnchor.constraint(equalToConstant: 25),
            rightImageView.widthAnchor.constraint(equalToConstant: 25),
            rightImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            rightImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        titleLabel.textColor = .black
        
        rightImageView.tintColor = Colors.red.uiColor
       // rightImageView.contentMode = .scaleAspectFit
        rightImageView.isHidden = true
        rightImageView.image = Images.exclamationmark.uiImage
    }
    
    func configure(with model: ConfigurationModel) {
        titleLabel.text = model.title
        rightImageView.isHidden = model.result
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
}



