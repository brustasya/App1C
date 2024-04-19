//
//  AddTeacherCell.swift
//  App1C
//
//  Created by Станислава on 19.04.2024.
//

import UIKit

class AddTeacherCell: UITableViewCell, ConfigurableViewProtocol {
    
    typealias ConfigurationModel = AddTeacherModel
        
    private lazy var titleLabel = UILabel()
    private lazy var leftImageView = UIImageView()
    private lazy var checkButton = UIButton()
    
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
        contentView.addSubview(titleLabel)
        contentView.addSubview(leftImageView)
        contentView.addSubview(checkButton)
        
        leftImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leftImageView.trailingAnchor, constant: 12),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            leftImageView.heightAnchor.constraint(equalToConstant: 25),
            leftImageView.widthAnchor.constraint(equalToConstant: 25),
            leftImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            leftImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            checkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            checkButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        titleLabel.textColor = .black
        
        leftImageView.tintColor = .darkGray
        leftImageView.contentMode = .scaleAspectFit
        leftImageView.image = Images.largePerson.uiImage
        
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
        isSelect = model.isTeacherCourse
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        leftImageView.image = nil
    }
}


