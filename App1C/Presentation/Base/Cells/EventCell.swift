//
//  EventCell.swift
//  App1C
//
//  Created by Станислава on 03.04.2024.
//

import UIKit

class EventCell: UITableViewCell, ConfigurableViewProtocol {
    
    typealias ConfigurationModel = EventModel
        
    private lazy var titleLabel = UILabel()
    private lazy var deadlineLabel = UILabel()
    private lazy var deadlineImageView = UIImageView()
    private lazy var eventImageView = UIImageView()
    private lazy var forwardButton = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(deadlineLabel)
        contentView.addSubview(eventImageView)
        contentView.addSubview(deadlineImageView)
        contentView.addSubview(forwardButton)
        
        eventImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        deadlineLabel.translatesAutoresizingMaskIntoConstraints = false
        deadlineImageView.translatesAutoresizingMaskIntoConstraints = false
        forwardButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: eventImageView.trailingAnchor, constant: 15),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -3),
            
            deadlineLabel.leadingAnchor.constraint(equalTo: eventImageView.trailingAnchor, constant: 15),
            deadlineLabel.topAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 4),
            
            deadlineImageView.heightAnchor.constraint(equalToConstant: 20),
            deadlineImageView.leadingAnchor.constraint(equalTo: deadlineLabel.trailingAnchor, constant: 6),
            deadlineImageView.centerYAnchor.constraint(equalTo: deadlineLabel.centerYAnchor),
            
            eventImageView.heightAnchor.constraint(equalToConstant: 30),
            eventImageView.widthAnchor.constraint(equalToConstant: 30),
            eventImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            eventImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            
            forwardButton.heightAnchor.constraint(equalToConstant: 20),
            forwardButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            forwardButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        titleLabel.textColor = .black
        
        deadlineLabel.font = UIFont.systemFont(ofSize: 14)
        deadlineLabel.textColor = .black
        
        deadlineImageView.image = Images.flame.uiImage
        eventImageView.tintColor = .gray

        deadlineImageView.tintColor = Colors.red.uiColor
        
        forwardButton.image = Images.forward.uiImage
        forwardButton.tintColor = .gray
    }
    
    func configure(with model: ConfigurationModel) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "d MMMM HH:mm"
        deadlineLabel.text = dateFormatter.string(from: model.deadline)
        eventImageView.image = makeEventImage(for: model.type)
        titleLabel.text = model.title
    }
    
    func setButtonVisible(visible: Bool) {
        forwardButton.isHidden = !visible
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
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        deadlineLabel.text = nil
        titleLabel.text = nil
        eventImageView.image = nil
    }
}
