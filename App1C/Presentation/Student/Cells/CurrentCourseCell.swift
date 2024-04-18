//
//  CurrentCourseCell.swift
//  App1C
//
//  Created by Станислава on 06.04.2024.
//

import UIKit

class CurrentCourseCell: UITableViewCell, ConfigurableViewProtocol {
    
    typealias ConfigurationModel = StudentCourseModel
        
    private lazy var titleLabel = UILabel()
    private lazy var regimLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(regimLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        regimLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            regimLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            regimLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: regimLabel.leadingAnchor, constant: -8),
            titleLabel.heightAnchor.constraint(equalToConstant: 35.9)
        ])
        
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 2
        
        regimLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        regimLabel.textColor = .gray
    }
    
    func configure(with model: ConfigurationModel) {
        titleLabel.text = model.title
        regimLabel.text = model.isOffline ? "Очно" : "Экстерн"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        regimLabel.text = nil
    }
}


