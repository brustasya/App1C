//
//  DiplomaViewController.swift
//  App1C
//
//  Created by Станислава on 06.05.2024.
//

import UIKit

class DiplomaViewController: UIViewController {
    private lazy var titleLabel = UILabel()
    
    private lazy var nameView = UIView()
    private lazy var nameTextField = UITextField()
    
    private lazy var themeTitle = UILabel()
    private lazy var themeView = UIView()
    private lazy var themeTextField = UITextField()
    private lazy var themeLabel = UILabel()
    
    private lazy var gradeTitle = UILabel()
    
    private lazy var telegramView = UIView()
    private lazy var telegramTextField = UITextField()
    
    private lazy var workView = UIView()
    private lazy var workTextField = UITextField()
    
    private lazy var postView = UIView()
    private lazy var postTextField = UITextField()
    
    private lazy var editButton = UIButton()
    
    private var output: DiplomaViewOutput

    init(output: DiplomaViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        setupTitle()
        setupTheme()
        setupGrade()
        setupTeacher()
        output.viewIsReady()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.viewWillAppear()
        navigationItem.hidesBackButton = true
        (navigationController as? CustomNavigationController)?.setupBackButton()
        (navigationController as? CustomNavigationController)?.backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
        tabBarController?.tabBar.isTranslucent = true
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        (navigationController as? CustomNavigationController)?.hideBackButton()
    }
    
    private func setupTitle() {
        titleLabel = TitleView(frame: CGRect(x: 30, y: 25, width: view.frame.width - 60, height: 60), title: "Студент")
        titleLabel.numberOfLines = 2
        view.addSubview(titleLabel)
    }
    
    private func setupTheme() {
        themeTitle.text = "Тема"
        themeLabel.translatesAutoresizingMaskIntoConstraints = false
        createTitle(title: themeTitle)
        createLargeTextField(textField: themeTextField, backgroundView: themeView)
        view.addSubview(themeLabel)

        themeTextField.placeholder = "Не указана"
        themeLabel.textColor = .black
        themeLabel.font = .systemFont(ofSize: 17)
        themeLabel.text = "Не указана"
        themeLabel.numberOfLines = 0
        themeLabel.isHidden = true
        
        NSLayoutConstraint.activate([
            themeTitle.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            themeView.topAnchor.constraint(equalTo: themeTitle.bottomAnchor, constant: 5),
            themeLabel.leadingAnchor.constraint(equalTo: themeTextField.leadingAnchor),
            themeLabel.topAnchor.constraint(equalTo: themeTextField.topAnchor),
            themeLabel.trailingAnchor.constraint(lessThanOrEqualTo: themeView.trailingAnchor)
        ])
    }
    
    private func setupGrade() {
        gradeTitle.text = "Оценка:"
        createTitle(title: gradeTitle)
        gradeTitle.font = .systemFont(ofSize: 17, weight: .medium)
        
        NSLayoutConstraint.activate([
            gradeTitle.topAnchor.constraint(equalTo: themeLabel.bottomAnchor, constant: 30)
        ])
    }
    
    private func setupGrade(gradeModel: GradeModel) {
        let gradeView = GradeView(model: gradeModel, contentView: view, frame: view.frame)
        view.addSubview(gradeView)
        gradeView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gradeView.leadingAnchor.constraint(equalTo: gradeTitle.trailingAnchor, constant: 20),
            gradeView.centerYAnchor.constraint(equalTo: gradeTitle.centerYAnchor),
            gradeView.widthAnchor.constraint(equalToConstant: 100),
            gradeView.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    private func setupTeacher() {
        let teacherTitle = UILabel()
        teacherTitle.text = "Научный руководитель"
        createTitle(title: teacherTitle)
        
        nameTextField.placeholder = "Не указан"
        createLargeTextField(textField: nameTextField, backgroundView: nameView)
        
        let contactsTitle = UILabel()
        contactsTitle.text = "Контакты:"
        createTextField(title: contactsTitle, textField: telegramTextField, backgroundView: telegramView)
        telegramTextField.placeholder = "Не указаны"
        
        let workTitle = UILabel()
        createTextField(title: workTitle, textField: workTextField, backgroundView: workView)
        workTitle.text = "Место работы:"
        workTextField.placeholder = "Не указано"
        
        let postTitle = UILabel()
        createTextField(title: postTitle, textField: postTextField, backgroundView: postView)
        postTitle.text = "Должность:"
        postTextField.placeholder = "Не указана"
        
        NSLayoutConstraint.activate([
            teacherTitle.topAnchor.constraint(equalTo: gradeTitle.bottomAnchor, constant: 30),
            nameView.topAnchor.constraint(equalTo: teacherTitle.bottomAnchor, constant: 5),
            contactsTitle.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 10),
            workTitle.topAnchor.constraint(equalTo: contactsTitle.bottomAnchor, constant: 20),
            postTitle.topAnchor.constraint(equalTo: workTitle.bottomAnchor, constant: 20),
        ])
    }
    
    private func createTitle(title: UILabel) {
        view.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = .black
        title.font = .systemFont(ofSize: 18, weight: .medium)
        
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        ])
    }
    
    private func createLargeTextField(textField: UITextField, backgroundView: UIView) {
        view.addSubview(backgroundView)
        backgroundView.addSubview(textField)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundView.layer.cornerRadius = 15
        backgroundView.backgroundColor = .white

        textField.backgroundColor = .white
        textField.textColor = .black
        textField.tintColor = .gray
        textField.isUserInteractionEnabled = false
        
        NSLayoutConstraint.activate([
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            backgroundView.heightAnchor.constraint(equalToConstant: 40),
            
            textField.heightAnchor.constraint(equalToConstant: 40),
            textField.widthAnchor.constraint(equalTo: backgroundView.widthAnchor, constant: -20),
            textField.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
        ])
        
    }
    
    private func createTextField(
        title: UILabel,
        textField: UITextField,
        backgroundView: UIView,
        secondTitle: Bool = false
    ) {
        let backTextFieldView = UIView()
        view.addSubview(backgroundView)
        backgroundView.addSubview(title)
        backTextFieldView.addSubview(textField)
        backgroundView.addSubview(backTextFieldView)
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        backTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        
        title.textColor = .black
        title.font = .systemFont(ofSize: 17, weight: .regular)
        
        backTextFieldView.layer.cornerRadius = 15
        backTextFieldView.backgroundColor = .white

        textField.backgroundColor = .white
        textField.textColor = .black
        textField.tintColor = .gray
        textField.isUserInteractionEnabled = false
        
        let titleMargin = secondTitle ? 20 : 10
        
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            backgroundView.heightAnchor.constraint(equalToConstant: 40),
            
            title.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: CGFloat(titleMargin)),
            title.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            
            backTextFieldView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -10),
            backTextFieldView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            backTextFieldView.heightAnchor.constraint(equalToConstant: 40),
            backTextFieldView.widthAnchor.constraint(equalToConstant: 200),
            
            textField.heightAnchor.constraint(equalToConstant: 40),
            textField.widthAnchor.constraint(equalToConstant: 180),
            textField.centerXAnchor.constraint(equalTo: backTextFieldView.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: backTextFieldView.centerYAnchor),
        ])
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func editProfile() {
        output.editButtonTapped()
    }
}

extension DiplomaViewController: DiplomaViewInput {
    func setupTitle(title: String) {
        titleLabel.text = title
    }
    
    func updateData(model: DiplomaModel) {
        themeTextField.text = model.theme
        nameTextField.text = model.name
        telegramTextField.text = model.contacts
        workTextField.text = model.work
        postTextField.text = model.post
        setupGrade(gradeModel: GradeModel(grade: model.grade))
        
        if model.theme != "" {
            switch model.themeType {
            case ThemeType.department.title:
                themeTitle.text = "Тема (от кафедры)"
            case ThemeType.work.title:
                themeTitle.text = "Тема (от работы)"
            case ThemeType.own.title:
                themeTitle.text = "Тема (своя)"
            default:
                themeTitle.text = "Тема"
            }
            themeLabel.text = model.theme
            themeLabel.isHidden = false
            themeTextField.isHidden = true
        } else {
            themeLabel.isHidden = true
            themeTextField.isHidden = false
        }
    }
    
    func setupEditButton() {
        let y = tabBarController?.tabBar.frame.minY ?? view.frame.maxY
        editButton = ButtonView(frame: CGRect(x: 25, y: y - 100, width: view.frame.width - 50, height: 45))
        view.addSubview(editButton)
        editButton.setTitle("Редактировать", for: .normal)
        
        editButton.addTarget(self, action: #selector(editProfile), for: .touchUpInside)
    }
}

