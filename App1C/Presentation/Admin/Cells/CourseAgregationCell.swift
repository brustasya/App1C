//
//  CourseAgregationCell.swift
//  App1C
//
//  Created by Станислава on 16.04.2024.
//

import UIKit

class CourseAgregationCell: UITableViewCell, ConfigurableViewProtocol {
    
    typealias ConfigurationModel = CourseAgregationModel
    
    weak var delegate: SelectItemDelegate?
    
    private lazy var titleLabel = UILabel()
    private lazy var infoButton = UIButton()
    private lazy var checkButton = UIButton()
    private lazy var offlineLabel = UILabel()
    private lazy var offlineCountLabel = UILabel()
    private lazy var onlineLabel = UILabel()
    private lazy var onlineCountLabel = UILabel()
    private lazy var contentBackgroundView = UIView()
    private lazy var id = 0
    
    private lazy var isStarted: Bool = false {
        didSet {
            checkButton.tintColor = isStarted ? Colors.darkgreen.uiColor : .gray
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
        contentView.backgroundColor = .systemGray6
        
        contentBackgroundView.layer.cornerRadius = 20
        contentBackgroundView.backgroundColor = .white
        contentBackgroundView.layer.borderColor = UIColor.black.cgColor
        contentBackgroundView.layer.borderWidth = 1
        
        contentView.addSubview(contentBackgroundView)
        contentBackgroundView.addSubview(titleLabel)
        contentBackgroundView.addSubview(infoButton)
        contentBackgroundView.addSubview(checkButton)
        contentBackgroundView.addSubview(offlineLabel)
        contentBackgroundView.addSubview(offlineCountLabel)
        contentBackgroundView.addSubview(onlineLabel)
        contentBackgroundView.addSubview(onlineCountLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        offlineLabel.translatesAutoresizingMaskIntoConstraints = false
        offlineCountLabel.translatesAutoresizingMaskIntoConstraints = false
        onlineLabel.translatesAutoresizingMaskIntoConstraints = false
        onlineCountLabel.translatesAutoresizingMaskIntoConstraints = false
        contentBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentBackgroundView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            contentBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentBackgroundView.heightAnchor.constraint(equalToConstant: 60),
            
            infoButton.trailingAnchor.constraint(equalTo: contentBackgroundView.trailingAnchor, constant: -10),
            infoButton.centerYAnchor.constraint(equalTo: contentBackgroundView.centerYAnchor)
        ])
        
        infoButton.setImage(Images.info.uiImage?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 23, weight: .medium)), for: .normal)
        infoButton.tintColor = .gray
        
        setupRegims()
        setupTitle()
    }
    
    private func setupTitle() {
        NSLayoutConstraint.activate([
            checkButton.leadingAnchor.constraint(equalTo: contentBackgroundView.leadingAnchor, constant: 10),
            checkButton.centerYAnchor.constraint(equalTo: contentBackgroundView.centerYAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: checkButton.trailingAnchor, constant: 8),
            titleLabel.widthAnchor.constraint(equalToConstant: 150),
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
        if isStarted {
            delegate?.unSelectItem(id: id)
        } else {
            delegate?.selectItem(id: id)
        }
        isStarted = !isStarted
    }
    
    private func setupRegims() {
        NSLayoutConstraint.activate([
            offlineCountLabel.bottomAnchor.constraint(equalTo: contentBackgroundView.centerYAnchor, constant: -4),
            offlineCountLabel.trailingAnchor.constraint(equalTo: infoButton.leadingAnchor, constant: -8),
            offlineLabel.trailingAnchor.constraint(equalTo: offlineCountLabel.leadingAnchor, constant: -4),
            offlineLabel.centerYAnchor.constraint(equalTo: offlineCountLabel.centerYAnchor),
            
            offlineLabel.widthAnchor.constraint(equalToConstant: 63),
            onlineLabel.widthAnchor.constraint(equalToConstant: 63),
            offlineCountLabel.widthAnchor.constraint(equalToConstant: 20),
            onlineCountLabel.widthAnchor.constraint(equalToConstant: 20),
            
            onlineCountLabel.topAnchor.constraint(equalTo: contentBackgroundView.centerYAnchor, constant: 4),
            onlineCountLabel.trailingAnchor.constraint(equalTo: infoButton.leadingAnchor, constant: -8),
            onlineLabel.trailingAnchor.constraint(equalTo: onlineCountLabel.leadingAnchor, constant: -4),
            onlineLabel.centerYAnchor.constraint(equalTo: onlineCountLabel.centerYAnchor)
        ])
        
        offlineLabel.text = "Очно:"
        onlineLabel.text = "Экстерн:"
        
        onlineLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        onlineLabel.textColor = .black
        onlineCountLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        onlineCountLabel.textColor = .black
        onlineCountLabel.textAlignment = .center
        offlineLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        offlineLabel.textColor = .black
        offlineCountLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        offlineCountLabel.textColor = .black
        offlineCountLabel.textAlignment = .center
    }
    
    func configure(with model: ConfigurationModel) {
        titleLabel.text = model.title
        offlineCountLabel.text = "\(model.offline)"
        onlineCountLabel.text = "\(model.online)"
        isStarted = model.isStarted
        id = model.id
    }
   
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
}



