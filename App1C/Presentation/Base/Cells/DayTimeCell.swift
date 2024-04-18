//
//  DayTimeCell.swift
//  App1C
//
//  Created by Станислава on 10.04.2024.
//

import UIKit

class DayTimeCell: UITableViewCell, ConfigurableViewProtocol {
    
    typealias ConfigurationModel = DayTimeModel
        
    private lazy var timeLabel = UILabel()
    private lazy var dayLable = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(timeLabel)
        contentView.addSubview(dayLable)
        
        dayLable.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timeLabel.leadingAnchor.constraint(equalTo: dayLable.trailingAnchor, constant: 12),
            timeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            dayLable.widthAnchor.constraint(equalToConstant: 70),
            dayLable.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            dayLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12)
        ])
        
        timeLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        timeLabel.textColor = .black
        
        dayLable.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        dayLable.textColor = .black
    }
    
    func configure(with model: ConfigurationModel) {
        timeLabel.text = model.time
        dayLable.text = model.day
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        timeLabel.text = nil
        dayLable.text = nil
    }
}


