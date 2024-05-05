//
//  NotificationCell.swift
//  App1C
//
//  Created by Станислава on 03.05.2024.
//

import UIKit

class NotificationCell: UITableViewCell, ConfigurableViewProtocol {
    
    typealias ConfigurationModel = NotificationModel
        
    private lazy var titleLabel = UILabel()
    private lazy var redCircle = UIImageView()
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
        contentBackgroundView.addSubview(redCircle)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        redCircle.translatesAutoresizingMaskIntoConstraints = false
        contentBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentBackgroundView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            contentBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            contentBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            contentBackgroundView.heightAnchor.constraint(equalToConstant: 65),
            
            titleLabel.centerYAnchor.constraint(equalTo: contentBackgroundView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentBackgroundView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: redCircle.leadingAnchor, constant: -8),
            titleLabel.heightAnchor.constraint(equalToConstant: 35.9),
            
            redCircle.heightAnchor.constraint(equalToConstant: 12),
            redCircle.widthAnchor.constraint(equalToConstant: 12),
            redCircle.trailingAnchor.constraint(equalTo: contentBackgroundView.trailingAnchor, constant: -10),
            redCircle.topAnchor.constraint(equalTo: contentBackgroundView.topAnchor, constant: 10)
        ])
        
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 2
        
        redCircle.backgroundColor = Colors.lightRed.uiColor
        redCircle.layer.cornerRadius = 6
        redCircle.isHidden = true
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
        redCircle.isHidden = !model.newEvent
    }
   
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        redCircle.isHidden = true
    }
}



