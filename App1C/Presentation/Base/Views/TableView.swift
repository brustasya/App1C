//
//  TableView.swift
//  App1C
//
//  Created by Станислава on 04.04.2024.
//

import UIKit

final class TableView: UIView {
    private let contentView: UIView
    private let titleText: String
    private let tableView: UITableView
    private let button: UIButton?
    private let largeTitle: Bool
    private let margin: CGFloat
    
    init(
        contentView: UIView,
        frame: CGRect,
        title: String,
        tableView: UITableView,
        button: UIButton? = nil,
        largeTitle: Bool = false,
        margin: CGFloat = 15
    ) {
        self.contentView = contentView
        self.titleText = title
        self.tableView = tableView
        self.button = button
        self.largeTitle = largeTitle
        self.margin = margin
        
        super.init(frame: frame)

        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        let titleLabel = UILabel()
        titleLabel.text = titleText
        
        contentView.addSubview(self)
        addSubview(titleLabel)
        addSubview(tableView)
        //tableView.translatesAutoresizingMaskIntoConstraints = false
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.layer.cornerRadius = 10
        tableView.layer.borderColor = UIColor.systemGray4.cgColor
        tableView.layer.borderWidth = 1
        tableView.isScrollEnabled = false
        
        backgroundColor = Colors.lightYellow.uiColor
        layer.cornerRadius = 10
        
        titleLabel.font = .systemFont(ofSize: largeTitle ? 24 : 18, weight: .semibold)
        titleLabel.textColor = .black
                
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -40),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            tableView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin)
        ])
        
        if let button = button {
            addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage(Images.up.uiImage, for: .normal)
            button.tintColor = .gray
            
            NSLayoutConstraint.activate([
                button.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
                button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
            ])
        }
    }
}

