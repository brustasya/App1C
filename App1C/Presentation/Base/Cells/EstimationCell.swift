//
//  EstimationCell.swift
//  App1C
//
//  Created by Станислава on 14.04.2024.
//

import UIKit

class EstimationCell: UITableViewCell, ConfigurableViewProtocol {
    
    typealias ConfigurationModel = EstimationModel
        
    weak var delegate: EstimationDelegate?
    
    private lazy var nameLabel = UILabel()
    private lazy var gradeView = UIView()
    private lazy var editButton = UIButton()
    private lazy var editView = UIView()
    private lazy var editTextField = UITextField()
    
    private lazy var isEdit: Bool = false
    private lazy var gradeModel: GradeModel = GradeModel(grade: 0)
    
    private var studentID: Int = 0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(editButton)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        editButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            nameLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width - 135),
            
            editButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            editButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            editButton.heightAnchor.constraint(equalToConstant: 30),
            editButton.widthAnchor.constraint(equalToConstant: 30),
        ])
        
        nameLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        nameLabel.textColor = .black
        nameLabel.numberOfLines = 2
        
        editButton.setImage(Images.edit.uiImage, for: .normal)
        editButton.tintColor = .darkGray
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        
        setupEditView()
    }
    
    private func setupGrade() {
        gradeView.removeFromSuperview()
        gradeView = GradeView(model: gradeModel, contentView: contentView, frame: contentView.frame)
        contentView.addSubview(gradeView)
        gradeView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gradeView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            gradeView.trailingAnchor.constraint(equalTo: editButton.leadingAnchor, constant: -8),
            gradeView.widthAnchor.constraint(equalToConstant: 90),
            gradeView.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(editButtonTapped))
        gradeView.addGestureRecognizer(gestureRecognizer)
    }
    
    private func setupEditView() {
        contentView.addSubview(editView)
        editView.translatesAutoresizingMaskIntoConstraints = false
        
        editView.backgroundColor = .systemGray6
        editView.layer.cornerRadius = 15
        editView.isHidden = true
        
        editView.addSubview(editTextField)
        editTextField.translatesAutoresizingMaskIntoConstraints = false
        editTextField.textColor = .black
        editTextField.font = .systemFont(ofSize: 14, weight: .regular)
        editTextField.textAlignment = .center
        editTextField.tintColor = .darkGray
        
        NSLayoutConstraint.activate([
            editView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            editView.trailingAnchor.constraint(equalTo: editButton.leadingAnchor, constant: -8),
            editView.widthAnchor.constraint(equalToConstant: 90),
            editView.heightAnchor.constraint(equalToConstant: 30),
            
            editTextField.centerYAnchor.constraint(equalTo: editView.centerYAnchor),
            editTextField.centerXAnchor.constraint(equalTo: editView.centerXAnchor),
            editTextField.leadingAnchor.constraint(equalTo: editView.leadingAnchor, constant: 10),
            editTextField.trailingAnchor.constraint(equalTo: editView.trailingAnchor, constant: -10)
        ])
    }
    
    func configure(with model: ConfigurationModel) {
        nameLabel.text = model.name
        self.gradeModel = model.grade
        editTextField.text = (gradeModel.grade > 0 && gradeModel.grade <= 10) ? "\(gradeModel.grade)" : ""
        self.studentID = model.studentID
        setupGrade()
    }
    
    @objc private func editButtonTapped() {
        if isEdit {
            editButton.setImage(Images.edit.uiImage, for: .normal)
            editButton.tintColor = .darkGray
            gradeModel = GradeModel(grade: Int(editTextField.text ?? "0") ?? 0)
            setupGrade()
            
            if let grade = Int(editTextField.text ?? "") {
                delegate?.estimate(id: studentID, grade: grade)
            }
        } else {
            editButton.setImage(Images.checkmark.uiImage, for: .normal)
            editButton.tintColor = Colors.darkgreen.uiColor
            editTextField.becomeFirstResponder()
        }
        gradeView.isHidden = !isEdit
        editView.isHidden = isEdit
        isEdit = !isEdit
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
    }
}


