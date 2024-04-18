//
//  TimetableCell.swift
//  App1C
//
//  Created by Станислава on 08.04.2024.
//

import UIKit

class TimetableCell: UITableViewCell, ConfigurableViewProtocol {
    
    typealias ConfigurationModel = TimetableModel
        
    private lazy var titleLabel = UILabel()
    private lazy var timeLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            timeLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        timeLabel.textColor = .black
        timeLabel.font = .systemFont(ofSize: 16, weight: .medium)
        timeLabel.textAlignment = .right
    }
    
    func configure(with model: ConfigurationModel) {
        timeLabel.text = model.time
        setupTitles(titles: model.titles)
    }
    
    private func setupTitles(titles: [String]) {
        var previous = UILabel()
        for (index, title) in titles.enumerated() {
            let titleLabel = UILabel()
            titleLabel.text = title
            titleLabel.textColor = .black
            titleLabel.textAlignment = .left
            titleLabel.numberOfLines = 0
            titleLabel.font = .systemFont(ofSize: 15, weight: .medium)
            
            contentView.addSubview(titleLabel)
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
                titleLabel.widthAnchor.constraint(equalToConstant: 200)
            ])
            
            if index == 0 {
                NSLayoutConstraint.activate([
                    titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12)
                ])
            } else {
                NSLayoutConstraint.activate([
                    titleLabel.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 12)
                ])
            }
            
            if index == titles.count - 1 {
                NSLayoutConstraint.activate([
                    contentView.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12)
                ])
            }
            
            previous = titleLabel
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        timeLabel.text = nil
    }
}


