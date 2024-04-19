//
//  AddDependenceCell.swift
//  App1C
//
//  Created by Станислава on 19.04.2024.
//

import UIKit

class AddDependenceCell: UITableViewCell, ConfigurableViewProtocol {
    
    typealias ConfigurationModel = AddDependenceModel
        
    private lazy var titleLabel = UILabel()
    private lazy var checkButton = UIButton()
    private lazy var contentBackgroundView = UIView()
    
    weak var delegate: SelectItemDelegate?
    
    private lazy var id: Int = 0
    private lazy var isSelect = false {
        didSet {
            checkButton.tintColor = isSelect ? Colors.darkgreen.uiColor : .gray
        }
    }
    
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
        contentBackgroundView.addSubview(titleLabel)
        contentBackgroundView.addSubview(checkButton)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        contentBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentBackgroundView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            contentBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentBackgroundView.heightAnchor.constraint(equalToConstant: 60),
        ])

        setupTitle()
    }
    
    private func setupTitle() {
        NSLayoutConstraint.activate([
            checkButton.leadingAnchor.constraint(equalTo: contentBackgroundView.leadingAnchor, constant: 10),
            checkButton.centerYAnchor.constraint(equalTo: contentBackgroundView.centerYAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: checkButton.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentBackgroundView.trailingAnchor, constant: -12),
            titleLabel.centerYAnchor.constraint(equalTo: contentBackgroundView.centerYAnchor)
        ])
        
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 2
        
        checkButton.tintColor = .gray
        checkButton.setImage(Images.check.uiImage?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 23, weight: .medium)), for: .normal)
        checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
    }
    
    @objc private func checkButtonTapped() {
        if isSelect {
            delegate?.unSelect(id: id)
        } else {
            delegate?.select(id: id)
        }
        isSelect = !isSelect
    }
    
    func configure(with model: ConfigurationModel) {
        titleLabel.text = model.title
        id = model.id
        isSelect = model.isCourseDependency
    }
   
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
}



