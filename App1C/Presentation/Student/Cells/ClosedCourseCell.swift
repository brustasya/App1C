//
//  ClosedCourseCell.swift
//  App1C
//
//  Created by Станислава on 05.04.2024.
//

import UIKit

class ClosedCourseCell: UITableViewCell, ConfigurableViewProtocol {
    
    typealias ConfigurationModel = StudentCourseModel
        
    private lazy var titleLabel = UILabel()
    private lazy var regimLabel = UILabel()
    private lazy var retakeLabel = UILabel()
    private lazy var gradeBackgroundView = UIView()
    private lazy var retakeView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(retakeView)
        contentView.addSubview(gradeBackgroundView)
        contentView.addSubview(regimLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        retakeView.translatesAutoresizingMaskIntoConstraints = false
        gradeBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        regimLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            regimLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            regimLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: regimLabel.leadingAnchor, constant: -8),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            gradeBackgroundView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            gradeBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            gradeBackgroundView.heightAnchor.constraint(equalToConstant: 30),
            gradeBackgroundView.widthAnchor.constraint(equalToConstant: 150),
            
            retakeView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            retakeView.leadingAnchor.constraint(equalTo: gradeBackgroundView.trailingAnchor, constant: 16),
            retakeView.heightAnchor.constraint(equalToConstant: 30),
            retakeView.widthAnchor.constraint(equalToConstant: 100)
            
        ])
        
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 2
        
        regimLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        regimLabel.textColor = .gray
        
        setupRetake()
    }
    
    private func setupGrade(with model: GradeModel) {
        let title = UILabel()
        let gradeView = GradeView(model: model, contentView: contentView, frame: contentView.frame)
        gradeBackgroundView.addSubview(gradeView)
        gradeView.translatesAutoresizingMaskIntoConstraints = false
        createSmallTitleLable(title: title, view: gradeBackgroundView)
        title.text = "Оценка:"
        
        NSLayoutConstraint.activate([
            gradeView.centerYAnchor.constraint(equalTo: gradeBackgroundView.centerYAnchor),
            gradeView.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: 8),
            gradeView.widthAnchor.constraint(equalToConstant: 70),
            gradeView.heightAnchor.constraint(equalToConstant: 30)
        ])
        
    }
    
    private func setupRetake() {
        let title = UILabel()
        retakeView.addSubview(retakeLabel)
        retakeLabel.translatesAutoresizingMaskIntoConstraints = false
        createSmallTitleLable(title: title, view: retakeView)
        title.text = "Пересдача:"
        retakeLabel.textColor = .darkGray
        retakeLabel.font = .systemFont(ofSize: 14, weight: .medium)
        
        NSLayoutConstraint.activate([
            retakeLabel.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: 8),
            retakeLabel.centerYAnchor.constraint(equalTo: retakeView.centerYAnchor)
        ])
    }
    
    func configure(with model: ConfigurationModel) {
        titleLabel.text = model.title
        regimLabel.text = model.isOffline ? "Очно" : "Экстерн"
        retakeLabel.text = model.isRetake ? "да" : "нет"
        setupGrade(with: model.grade)
    }
    
    private func createSmallTitleLable(title: UILabel, view: UIView) {
        view.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = .black
        title.font = .systemFont(ofSize: 14, weight: .regular)
        
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            title.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        regimLabel.text = nil
        retakeLabel.text = nil
    }
}


