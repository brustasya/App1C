//
//  LargeBaseCell.swift
//  App1C
//
//  Created by Станислава on 04.04.2024.
//

import UIKit

class LargeBaseCell: UITableViewCell, ConfigurableViewProtocol {
    
    typealias ConfigurationModel = BaseModel
        
    private lazy var titleLabel = UILabel()
    private lazy var leftImageView = UIImageView()
    private lazy var rightImageView = UIImageView()
    
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
        contentView.addSubview(rightImageView)
        
        leftImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        rightImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leftImageView.trailingAnchor, constant: 12),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            leftImageView.heightAnchor.constraint(equalToConstant: 36),
            leftImageView.widthAnchor.constraint(equalToConstant: 36),
            leftImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            leftImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            rightImageView.heightAnchor.constraint(equalToConstant: 20),
            rightImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            rightImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        titleLabel.textColor = .black
        
        leftImageView.tintColor = Colors.red.uiColor
        leftImageView.contentMode = .scaleAspectFit
        rightImageView.tintColor = .gray
    }
    
    func configure(with model: ConfigurationModel) {
        titleLabel.text = model.title
        leftImageView.image = model.image
        rightImageView.image = model.buttonImage
    }
    
    private func makeEventImage(for type: EventType) -> UIImage? {
        switch type {
        case .preliminaryCourseChoice:
            return Images.graduationcapfill.uiImage
        case .finalCourseChoice:
            return Images.graduationcapfill.uiImage
        case .diplomaThemeChoice:
            return Images.book.uiImage
        case .estimating:
            return Images.estimating.uiImage
        case .diplomaSpeech:
            return Images.book.uiImage
        case .diplomaThemeCorrection:
            return Images.book.uiImage
        case .message:
            return nil
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        leftImageView.image = nil
    }
}

