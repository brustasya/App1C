//
//  SpeechResultCell.swift
//  App1C
//
//  Created by Станислава on 07.05.2024.
//

import UIKit

class SpeechResultCell: UITableViewCell, ConfigurableViewProtocol {
    
    typealias ConfigurationModel = SpeechResultModel
    
    weak var delegate: SpeechSelectorDelegate?
    
    private lazy var nameLabel = UILabel()
    private lazy var checkButton = UIButton()
    private lazy var themeLabel = UILabel()
    private lazy var resultLabel = UILabel()
    private lazy var contentBackgroundView = UIView()
    private lazy var studentID = 0
    private lazy var speechID = 0
    
    private lazy var isWarning: Bool = false {
        didSet {
            checkButton.tintColor = isWarning ? Colors.red.uiColor : .gray
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
        contentBackgroundView.addSubview(nameLabel)
        contentBackgroundView.addSubview(checkButton)
        contentBackgroundView.addSubview(themeLabel)
        contentBackgroundView.addSubview(resultLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        themeLabel.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        contentBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            contentBackgroundView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            nameLabel.topAnchor.constraint(equalTo: contentBackgroundView.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: contentBackgroundView.leadingAnchor, constant: 15),
            themeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            themeLabel.leadingAnchor.constraint(equalTo: contentBackgroundView.leadingAnchor, constant: 15),
            themeLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentBackgroundView.trailingAnchor, constant: -15),
            checkButton.topAnchor.constraint(equalTo: themeLabel.bottomAnchor, constant: 8),
            checkButton.trailingAnchor.constraint(equalTo: contentBackgroundView.trailingAnchor, constant: -10),
            resultLabel.trailingAnchor.constraint(equalTo: checkButton.leadingAnchor, constant: -5),
            resultLabel.centerYAnchor.constraint(equalTo: checkButton.centerYAnchor),
            contentBackgroundView.bottomAnchor.constraint(equalTo: checkButton.bottomAnchor, constant: 10),
            contentView.bottomAnchor.constraint(equalTo: contentBackgroundView.bottomAnchor, constant: 5)
        ])
        
        nameLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        nameLabel.textColor = .black
        
        resultLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        resultLabel.textColor = .black
        resultLabel.text = "Предупреждение: "
        
        themeLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        themeLabel.textColor = .black
        themeLabel.numberOfLines = 0
        
        checkButton.tintColor = .gray
        checkButton.setImage(Images.check.uiImage?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 23, weight: .medium)), for: .normal)
        checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
    }
    
    @objc private func checkButtonTapped() {
        if isWarning {
            delegate?.select(studentID: studentID, speechID: speechID)
        } else {
            delegate?.unSelect(studentID: studentID, speechID: speechID)
        }
        isWarning = !isWarning
    }
    
    func configure(with model: ConfigurationModel) {
        nameLabel.text = model.name
        isWarning = !model.result
        studentID = model.studentID
        speechID = model.speechID
        themeLabel.text = model.theme
    }
   
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
    }
}



