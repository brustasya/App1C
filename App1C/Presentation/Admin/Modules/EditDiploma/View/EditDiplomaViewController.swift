//
//  EditDiplomaViewController.swift
//  App1C
//
//  Created by Станислава on 06.05.2024.
//

import UIKit

class EditDiplomaViewController: UIViewController {
    private lazy var titleLabel = UILabel()
    
    private lazy var surnameView = UIView()
    private lazy var surnameTextField = UITextField()
    
    private lazy var nameView = UIView()
    private lazy var nameTextField = UITextField()
    
    private lazy var themeView = UIView()
    private lazy var themeTextField = UITextField()
    
    private lazy var typeTitle = UILabel()
    
    private lazy var patronymicView = UIView()
    private lazy var patronymicTextField = UITextField()
    
    private lazy var telegramView = UIView()
    private lazy var telegramTextField = UITextField()
    
    private lazy var workView = UIView()
    private lazy var workTextField = UITextField()
    
    private lazy var postView = UIView()
    private lazy var postTextField = UITextField()
    
    let semesterTitle = UILabel()
    private lazy var semesterView = UIView()
    private lazy var semesterTextField = UITextField()
    
    private lazy var typeBackgroundView = UIView()
    private lazy var typeLabel = UILabel()
    
    private lazy var saveButton = UIButton()
    private lazy var editButton = UIButton()
    
    let startDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.tintColor = .black
        datePicker.locale = Locale(identifier: "ru_RU")
        return datePicker
    }()
    
    let endDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.tintColor = .black
        datePicker.locale = Locale(identifier: "ru_RU")
        return datePicker
    }()
    
    private var output: EditDiplomaViewOutput

    init(output: EditDiplomaViewOutput) {
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
        setupType()
        setupTeacher()
        setupSaveButton()
        output.viewIsReady()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        titleLabel = TitleView(frame: CGRect(x: 30, y: 25, width: view.frame.width - 60, height: 60), title: "Бобрускина Станислава Алексеевна")
        titleLabel.numberOfLines = 2
        view.addSubview(titleLabel)
    }
    
    private func setupTheme() {
        let themeTitle = UILabel()
        themeTitle.text = "Тема"
        createTitle(title: themeTitle)
        createLargeTextField(textField: themeTextField, backgroundView: themeView)
        themeTextField.placeholder = "Введите тему диплома"
        
        NSLayoutConstraint.activate([
            themeTitle.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            themeView.topAnchor.constraint(equalTo: themeTitle.bottomAnchor, constant: 10)
        ])
    }
    
    private func setupType() {
        typeTitle.text = "Тип темы:"
        createTitle(title: typeTitle)
        typeTitle.font = .systemFont(ofSize: 17, weight: .regular)
        
        view.addSubview(typeBackgroundView)
        typeBackgroundView.addSubview(typeLabel)
        typeBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        typeLabel.text = ThemeType.department.title
        
        typeBackgroundView.backgroundColor = Colors.paleYellow.uiColor
        typeBackgroundView.layer.cornerRadius = 15
        
        NSLayoutConstraint.activate([
            typeTitle.topAnchor.constraint(equalTo: themeView.bottomAnchor, constant: 20),
            typeBackgroundView.leadingAnchor.constraint(equalTo: typeTitle.trailingAnchor, constant: 20),
            typeBackgroundView.centerYAnchor.constraint(equalTo: typeTitle.centerYAnchor),
            typeBackgroundView.widthAnchor.constraint(equalToConstant: 160),
            typeBackgroundView.heightAnchor.constraint(equalToConstant: 35),
            
            typeLabel.centerYAnchor.constraint(equalTo: typeBackgroundView.centerYAnchor),
            typeLabel.centerXAnchor.constraint(equalTo: typeBackgroundView.centerXAnchor)
        ])
        
        let tapGesturerecognizer = UITapGestureRecognizer(target: self, action: #selector(showTypesAlert))
        typeBackgroundView.addGestureRecognizer(tapGesturerecognizer)
    }
    
    private func setupTeacher() {
        let teacherTitle = UILabel()
        teacherTitle.text = "Научный руководитель"
        createTitle(title: teacherTitle)
        
        nameTextField.placeholder = "Введите ФИО руководителя"
        createLargeTextField(textField: nameTextField, backgroundView: nameView)
        
        let contactsTitle = UILabel()
        contactsTitle.text = "Контакты:"
        createTextField(title: contactsTitle, textField: telegramTextField, backgroundView: telegramView)
        //telegramTextField.placeholder = "Введите свои контакты"
        
        let workTitle = UILabel()
        createTextField(title: workTitle, textField: workTextField, backgroundView: workView)
        workTitle.text = "Место работы:"
       // workTextField.placeholder = "Введите место работы"
        
        let postTitle = UILabel()
        createTextField(title: postTitle, textField: postTextField, backgroundView: postView)
        postTitle.text = "Должность:"
        //postTextField.placeholder = "Введите должность"
        
        NSLayoutConstraint.activate([
            teacherTitle.topAnchor.constraint(equalTo: typeTitle.bottomAnchor, constant: 40),
            nameView.topAnchor.constraint(equalTo: teacherTitle.bottomAnchor, constant: 10),
            contactsTitle.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 20),
            workTitle.topAnchor.constraint(equalTo: contactsTitle.bottomAnchor, constant: 30),
            postTitle.topAnchor.constraint(equalTo: workTitle.bottomAnchor, constant: 30),
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
        backgroundView.backgroundColor = .systemGray6

        textField.backgroundColor = .systemGray6
        textField.textColor = .black
        textField.tintColor = .gray
        
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
        backTextFieldView.backgroundColor = .systemGray6

        textField.backgroundColor = .systemGray6
        textField.textColor = .black
        textField.tintColor = .gray
        
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
    
    private func setupSaveButton() {
        let y = tabBarController?.tabBar.frame.minY ?? view.frame.maxY
        saveButton = ButtonView(frame: CGRect(x: 25, y: y - 100, width: view.frame.width - 50, height: 45))
        view.addSubview(saveButton)
        saveButton.setTitle("Сохранить", for: .normal)
        
        saveButton.addTarget(self, action: #selector(saveProfile), for: .touchUpInside)
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func saveProfile() {
        let model = DiplomaModel(
            studentName: nil,
            theme: themeTextField.text ?? "",
            themeType: typeLabel.text ?? "",
            grade: 0,
            name: nameTextField.text ?? "",
            contacts: telegramTextField.text ?? "",
            post: postTextField.text ?? "",
            work: workTextField.text ?? ""
        )
        output.saveButtonTapped(model: model)
    }
    
    @objc private func showTypesAlert() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        addAlertAction(title: ThemeType.own.title, alert: alertController, label: typeLabel)
        addAlertAction(title: ThemeType.department.title, alert: alertController, label: typeLabel)
        addAlertAction(title: ThemeType.work.title, alert: alertController, label: typeLabel)
       
        alertController.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        alertController.view.backgroundColor = Colors.yellow.uiColor
        alertController.view.tintColor = .black
        alertController.view.layer.cornerRadius = 15

        present(alertController, animated: true)
    }
    
    private func addAlertAction(title: String, alert: UIAlertController, label: UILabel) {
        alert.addAction(UIAlertAction(title: title, style: .default) { _ in
            label.text = title
        })
    }
}

extension EditDiplomaViewController: EditDiplomaViewInput {
    func setupTitle(title: String) {
        titleLabel.text = title
    }
    
    func updateData(model: DiplomaModel) {
        themeTextField.text = model.theme
        typeLabel.text = model.themeType
        nameTextField.text = model.name
        telegramTextField.text = model.contacts
        workTextField.text = model.work
        postTextField.text = model.post
    }
    
    func close() {
        goBack()
    }
}

