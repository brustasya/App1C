//
//  CourseEstimationCell.swift
//  App1C
//
//  Created by Станислава on 09.05.2024.
//

import UIKit

class CourseEstimationCell: UITableViewCell, ConfigurableViewProtocol {
    
    typealias ConfigurationModel = StudentCourseModel
        
    private lazy var contentBackgroundView = UIView()
    private lazy var titleLabel = UILabel()
    private lazy var regimLabel = UILabel()
    private lazy var loadLabel = UILabel()
    private lazy var retakeButton = UIButton()
    private lazy var gradeBackgroundView = UIView()
    private lazy var gradeView = UIView()
    private lazy var gradeTitle = UILabel()
    private lazy var retakeView = UIView()
    
    private var isRetake = false {
        didSet {
            retakeButton.tintColor = isRetake ? Colors.red.uiColor : .gray
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
        contentBackgroundView.addSubview(retakeView)
        contentBackgroundView.addSubview(gradeBackgroundView)
        contentBackgroundView.addSubview(regimLabel)
        contentBackgroundView.addSubview(loadLabel)
        
        contentBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        retakeView.translatesAutoresizingMaskIntoConstraints = false
        gradeBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        regimLabel.translatesAutoresizingMaskIntoConstraints = false
        loadLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            contentBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: contentBackgroundView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentBackgroundView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentBackgroundView.trailingAnchor, constant: -16),
            
            gradeBackgroundView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            gradeBackgroundView.leadingAnchor.constraint(equalTo: contentBackgroundView.leadingAnchor, constant: 16),
            gradeBackgroundView.heightAnchor.constraint(equalToConstant: 30),
            gradeBackgroundView.widthAnchor.constraint(equalToConstant: 150),
            
            retakeView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            retakeView.leadingAnchor.constraint(equalTo: gradeBackgroundView.trailingAnchor, constant: 16),
            retakeView.heightAnchor.constraint(equalToConstant: 30),
            retakeView.widthAnchor.constraint(equalToConstant: 100),
            
            regimLabel.topAnchor.constraint(equalTo: gradeBackgroundView.bottomAnchor, constant: 8),
            regimLabel.leadingAnchor.constraint(equalTo: contentBackgroundView.centerXAnchor),
            
            loadLabel.topAnchor.constraint(equalTo: gradeBackgroundView.bottomAnchor, constant: 8),
            loadLabel.leadingAnchor.constraint(equalTo: contentBackgroundView.leadingAnchor, constant: 16),
            
            contentBackgroundView.bottomAnchor.constraint(equalTo: regimLabel.bottomAnchor, constant: 10),
            contentView.bottomAnchor.constraint(equalTo: contentBackgroundView.bottomAnchor, constant: 5)
            
            
        ])
        
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        
        regimLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        regimLabel.textColor = .gray
        
        loadLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        loadLabel.textColor = .gray
        
        setupRetake()
        setupGradeView()
    }
    
    private func setupGradeView() {
        createSmallTitleLable(title: gradeTitle, view: gradeBackgroundView)
        gradeTitle.text = "Оценка:"
        setGrade(with: GradeModel(grade: 0))
    }
    
    private func setGrade(with model: GradeModel) {
        gradeView = GradeView(model: model, contentView: contentView, frame: contentView.frame)
        gradeBackgroundView.addSubview(gradeView)
        gradeView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gradeView.centerYAnchor.constraint(equalTo: gradeBackgroundView.centerYAnchor),
            gradeView.leadingAnchor.constraint(equalTo: gradeTitle.trailingAnchor, constant: 8),
            gradeView.widthAnchor.constraint(equalToConstant: 90),
            gradeView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupRetake() {
        let title = UILabel()
        retakeView.addSubview(retakeButton)
        retakeButton.translatesAutoresizingMaskIntoConstraints = false
        createSmallTitleLable(title: title, view: retakeView)
        title.text = "Пересдача:"
        retakeButton.setImage(Images.info.uiImage?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 23, weight: .medium)), for: .normal)
        retakeButton.tintColor = .gray
        
        NSLayoutConstraint.activate([
            retakeButton.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: 8),
            retakeButton.centerYAnchor.constraint(equalTo: retakeView.centerYAnchor)
        ])
    }
    
    func configure(with model: ConfigurationModel) {
        titleLabel.text = model.title
        regimLabel.text = model.isOffline ? "Очно" : "Экстерн"
        loadLabel.text = model.wasInLoad ? "В нагрузке" : "Не в нагрузке"
        isRetake = model.isRetake
        gradeView.removeFromSuperview()
        setGrade(with: model.grade)
    }
    
    func setGrade(grade: Int) {
        setGrade(with: GradeModel(grade: grade))
    }
    
    @objc private func retakeButtonTapped() {
        isRetake = !isRetake
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
    }
}


