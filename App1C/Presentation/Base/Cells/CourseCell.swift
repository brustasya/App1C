//
//  CourseCell.swift
//  App1C
//
//  Created by Станислава on 08.04.2024.
//

import UIKit

class CourseCell: UITableViewCell, ConfigurableViewProtocol {
    
    typealias ConfigurationModel = CourseModel
        
    private lazy var titleLabel = UILabel()
    private lazy var forwardButton = UIImageView()
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
        contentBackgroundView.backgroundColor = Colors.lightYellow.uiColor
        
        contentView.addSubview(contentBackgroundView)
        contentBackgroundView.addSubview(titleLabel)
        contentBackgroundView.addSubview(forwardButton)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        forwardButton.translatesAutoresizingMaskIntoConstraints = false
        contentBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentBackgroundView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            contentBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentBackgroundView.heightAnchor.constraint(equalToConstant: 65),
            
            titleLabel.centerYAnchor.constraint(equalTo: contentBackgroundView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentBackgroundView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: forwardButton.leadingAnchor, constant: -8),
            titleLabel.heightAnchor.constraint(equalToConstant: 35.9),
            
            forwardButton.heightAnchor.constraint(equalToConstant: 20),
            forwardButton.trailingAnchor.constraint(equalTo: contentBackgroundView.trailingAnchor, constant: -10),
            forwardButton.centerYAnchor.constraint(equalTo: contentBackgroundView.centerYAnchor)
        ])
        
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 2
        
        forwardButton.image = Images.forward.uiImage
        forwardButton.tintColor = .gray
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        contentView.backgroundColor = .white
        if selected {
            UIView.animate(withDuration: 0.3, animations: {
                self.contentBackgroundView.backgroundColor = .systemGray6
            }, completion: { finished in
                UIView.animate(withDuration: 0.3, animations: {
                    self.contentBackgroundView.backgroundColor = Colors.lightYellow.uiColor
                })
            })
        } else {
            contentBackgroundView.backgroundColor = Colors.lightYellow.uiColor
        }
    }
    
    func configure(with model: ConfigurationModel) {
        titleLabel.text = model.title
    }
   
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
}



