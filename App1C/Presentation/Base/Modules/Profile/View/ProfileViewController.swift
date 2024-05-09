//
//  ProfileViewController.swift
//  App1C
//
//  Created by Станислава on 09.04.2024.
//

import UIKit

class ProfileViewController: UIViewController {
    private lazy var titleLabel = UILabel()
    
    private lazy var surnameView = UIView()
    private lazy var surnameTextField = UITextField()
    
    private lazy var nameView = UIView()
    private lazy var nameTextField = UITextField()
    
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
    
    private lazy var statusBackgroundView = UIView()
    private lazy var statusLabel = UILabel()
    
    private lazy var saveButton = UIButton()
    private lazy var editButton = UIButton()
    private lazy var gradesButton = UIButton()
    
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
    
    private var output: ProfileViewOutput

    init(output: ProfileViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        setupTitle()
        setupSurname()
        setupContacts()
        output.viewIsReady()
//        setupWorkTime()
//        setupEditButton()
//        setupSemester()
//        setupStatus()
//        setupWork()
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
        titleLabel = TitleView(frame: CGRect(x: 30, y: 25, width: view.frame.width, height: 30), title: "Личные данные")
        view.addSubview(titleLabel)
    }
    
    private func setupSurname() {
        let surnameTitle = UILabel()
        createTextField(title: surnameTitle, textField: surnameTextField, backgroundView: surnameView)
        surnameTitle.text = "Фамилия"
        surnameTextField.placeholder = "Не указана"
        
        let nameTitle = UILabel()
        createTextField(title: nameTitle, textField: nameTextField, backgroundView: nameView)
        nameTitle.text = "Имя"
        nameTextField.placeholder = "Не указано"
        
        let patronymicTitle = UILabel()
        createTextField(title: patronymicTitle, textField: patronymicTextField, backgroundView: patronymicView)
        patronymicTitle.text = "Отчество"
        patronymicTextField.placeholder = "Не указано"
        
        NSLayoutConstraint.activate([
            surnameView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            nameView.topAnchor.constraint(equalTo: surnameView.bottomAnchor, constant: 10),
            patronymicView.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 10)
        ])
    }
    
    private func setupContacts() {
        let contactsTitle = UILabel()
        createTitle(title: contactsTitle)
        contactsTitle.text = "Контакты:"
        
        let telegramTitle = UILabel()
        createTextField(title: telegramTitle, textField: telegramTextField, backgroundView: telegramView, secondTitle: true)
        telegramTitle.text = "Telegram"
        telegramTextField.placeholder = "Не указан"
        
        NSLayoutConstraint.activate([
            contactsTitle.topAnchor.constraint(equalTo: patronymicView.bottomAnchor, constant: 20),
            telegramView.topAnchor.constraint(equalTo: contactsTitle.bottomAnchor, constant: 10)
        ])
    }
    
    private func setupSemester() {
        createTitle(title: semesterTitle)
        semesterTitle.text = "Семестр:"
        
        view.addSubview(semesterView)
        semesterView.addSubview(semesterTextField)
        semesterView.translatesAutoresizingMaskIntoConstraints = false
        semesterTextField.translatesAutoresizingMaskIntoConstraints = false
        semesterTextField.textAlignment = .center
        semesterTextField.placeholder = "#"
        
        semesterView.layer.cornerRadius = 15
        semesterView.backgroundColor = .systemGray6
        
        semesterTextField.textColor = .black
        semesterTextField.backgroundColor = .systemGray6
        semesterTextField.tintColor = .gray
        
        NSLayoutConstraint.activate([
            semesterView.topAnchor.constraint(equalTo: telegramView.bottomAnchor, constant: 20),
            semesterTitle.centerYAnchor.constraint(equalTo: semesterView.centerYAnchor),
            semesterTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            semesterView.trailingAnchor.constraint(equalTo: telegramView.trailingAnchor, constant: -170),
            semesterView.heightAnchor.constraint(equalToConstant: 40),
            semesterView.widthAnchor.constraint(equalToConstant: 60),
            
            semesterTextField.heightAnchor.constraint(equalToConstant: 40),
            semesterTextField.widthAnchor.constraint(equalToConstant: 40),
            semesterTextField.centerXAnchor.constraint(equalTo: semesterView.centerXAnchor),
            semesterTextField.centerYAnchor.constraint(equalTo: semesterView.centerYAnchor),
        ])
    }
    
    private func setupStatus() {
        let statusTitle = UILabel()
        createTitle(title: statusTitle)
        statusTitle.text = "Статус:"
        
        view.addSubview(statusBackgroundView)
        statusBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        statusBackgroundView.backgroundColor = Colors.paleYellow.uiColor
        statusBackgroundView.layer.cornerRadius = 12.5
        
        statusBackgroundView.addSubview(statusLabel)
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.textColor = .black
        statusLabel.font = .systemFont(ofSize: 16, weight: .regular)
        statusLabel.text = "Учится"
        
        NSLayoutConstraint.activate([
            statusTitle.topAnchor.constraint(equalTo: semesterView.bottomAnchor, constant: 20),
            
            statusBackgroundView.widthAnchor.constraint(equalToConstant: 120),
            statusBackgroundView.heightAnchor.constraint(equalToConstant: 25),
            statusBackgroundView.centerYAnchor.constraint(equalTo: statusTitle.centerYAnchor),
            statusBackgroundView.leadingAnchor.constraint(equalTo: statusTitle.trailingAnchor, constant: 50),
            
            statusLabel.centerYAnchor.constraint(equalTo: statusBackgroundView.centerYAnchor),
            statusLabel.centerXAnchor.constraint(equalTo: statusBackgroundView.centerXAnchor)
        ])
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(changeStatus))
        statusBackgroundView.addGestureRecognizer(gestureRecognizer)
        statusBackgroundView.isUserInteractionEnabled = true
    }
    
    private func setupWork() {
        let workTitle = UILabel()
        createTitle(title: workTitle)
        workTitle.text = "Место работы:"
        workTextField.placeholder = "Не указано"
        
        view.addSubview(workView)
        workView.addSubview(workTextField)
        workView.translatesAutoresizingMaskIntoConstraints = false
        workTextField.translatesAutoresizingMaskIntoConstraints = false
        workView.layer.cornerRadius = 15
        workView.backgroundColor = .systemGray6

        workTextField.backgroundColor = .systemGray6
        workTextField.textColor = .black
        workTextField.tintColor = .gray
        
        let postTitle = UILabel()
        createTextField(title: postTitle, textField: postTextField, backgroundView: postView)
        postTitle.text = "Должность"
        postTextField.placeholder = "Не указана"
        
        NSLayoutConstraint.activate([
            workTitle.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 20),
            workView.topAnchor.constraint(equalTo: workTitle.bottomAnchor, constant: 10),
            postView.topAnchor.constraint(equalTo: workView.bottomAnchor, constant: 10),
            
            workView.heightAnchor.constraint(equalToConstant: 40),
            workView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            workView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            workTextField.heightAnchor.constraint(equalToConstant: 40),
            workTextField.leadingAnchor.constraint(equalTo: workView.leadingAnchor, constant: 15),
            workTextField.trailingAnchor.constraint(equalTo: workView.trailingAnchor, constant: -15),
            workTextField.centerXAnchor.constraint(equalTo: workView.centerXAnchor),
            workTextField.centerYAnchor.constraint(equalTo: workView.centerYAnchor),
        ])
    }
    
    private func setupWorkTime() {
        let workTimeTitle = UILabel()
        createTitle(title: workTimeTitle)
        workTimeTitle.text = "Рабочее время:"
        
        let separatorLabel = UILabel()
        view.addSubview(separatorLabel)
        separatorLabel.translatesAutoresizingMaskIntoConstraints = false
        separatorLabel.text = ":"
        separatorLabel.textColor = .black
        separatorLabel.font = .systemFont(ofSize: 17)
        
        view.addSubview(startDatePicker)
        view.addSubview(endDatePicker)
        startDatePicker.translatesAutoresizingMaskIntoConstraints = false
        endDatePicker.translatesAutoresizingMaskIntoConstraints = false
        createDatePicker(datePicker: startDatePicker, hour: 9, minute: 0)
        createDatePicker(datePicker: endDatePicker, hour: 18, minute: 0)

        
        NSLayoutConstraint.activate([
            workTimeTitle.topAnchor.constraint(equalTo: telegramView.bottomAnchor, constant: 30),
            startDatePicker.heightAnchor.constraint(equalToConstant: 40),
            endDatePicker.heightAnchor.constraint(equalToConstant: 40),
            startDatePicker.centerYAnchor.constraint(equalTo: workTimeTitle.centerYAnchor),
            endDatePicker.centerYAnchor.constraint(equalTo: workTimeTitle.centerYAnchor),
            separatorLabel.centerYAnchor.constraint(equalTo: workTimeTitle.centerYAnchor),
            startDatePicker.leadingAnchor.constraint(equalTo: workTimeTitle.trailingAnchor, constant: 20),
            separatorLabel.leadingAnchor.constraint(equalTo: startDatePicker.trailingAnchor, constant: 5),
            endDatePicker.leadingAnchor.constraint(equalTo: separatorLabel.trailingAnchor, constant: 5)
        ])
    }
    
    private func createDatePicker(datePicker: UIDatePicker, hour: Int, minute: Int) {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        if let initialDate = calendar.date(from: dateComponents) {
            datePicker.date = initialDate
        }
        
        for subView in datePicker.subviews {
            for view in subView.subviews {
                view.backgroundColor = .systemGray6
                view.layer.cornerRadius = 15
                for sub in view.subviews {
                    sub.backgroundColor = .systemGray6
                    sub.layer.cornerRadius = 15
                }
            }
        }
    }
    
    private func createTitle(title: UILabel) {
        view.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = .black
        title.font = .systemFont(ofSize: 17, weight: .medium)
        
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
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
            backTextFieldView.widthAnchor.constraint(equalToConstant: 220),
            
            textField.heightAnchor.constraint(equalToConstant: 40),
            textField.widthAnchor.constraint(equalToConstant: 190),
            textField.centerXAnchor.constraint(equalTo: backTextFieldView.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: backTextFieldView.centerYAnchor),
        ])
    }
    
    private func enableEditMode() {
        nameTextField.placeholder = "Введите имя"
        surnameTextField.placeholder = "Введите фамилию"
        patronymicTextField.placeholder = "Введите отчество"
        telegramTextField.placeholder = ""
//        startDatePicker.placeholder = ""
//        endDatePicker.placeholder = ""
        workTextField.placeholder = "Введите место работы"
        postTextField.placeholder = "Введите занимаемую должность"
        semesterTextField.placeholder = "#"
    }
    
    private func disableEditMode() {
        nameTextField.placeholder = "Не указано"
        surnameTextField.placeholder = "Не указана"
        patronymicTextField.placeholder = "Не указано"
        telegramTextField.placeholder = ""
//        startDatePicker.placeholder = ""
//        endDatePicker.placeholder = ""
        workTextField.placeholder = "Не указано"
        postTextField.placeholder = "Не указана"
        semesterTextField.placeholder = "#"
    }
    
    @objc func goBack() {
        if output.goBack() {
            navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func editProfile() {
        output.editButtonTapped()
    }
    
    @objc func saveProfile() {
        output.saveButtonTapped(
            name: nameTextField.text ?? "",
            surname: surnameTextField.text ?? "",
            patronymic: patronymicTextField.text,
            telegram: telegramTextField.text,
            semester: Int(semesterTextField.text ?? "5") ?? 5,
            isInAcademicLeave: statusLabel.text == "В академе",
            workPlace: postTextField.text,
            job: workTextField.text,
            from: startDatePicker.date,
            to: endDatePicker.date
        )
    }
    
    @objc func changeStatus() {
        if statusLabel.text == "Учится" {
            statusLabel.text = "В академе"
        } else {
            statusLabel.text = "Учится"
        }
    }
    
    @objc func gradesButtonTapped() {
        output.openGrades(controller: navigationController)
    }
}

extension ProfileViewController: ProfileViewInput {
    func setupTitle(title: String) {
        titleLabel.text = title
    }
    
    func setupStudentFields() {
        setupSemester()
        setupStatus()
        setupWork()
    }
    
    func updateStuedntData(name: String, surname: String, patronymic: String?,
                            telegram: String?, semester: Int, isInAcademivLeave: Bool,
                            workPlace: String?, job: String?) {
        nameTextField.text = name
        surnameTextField.text = surname
        patronymicTextField.text = patronymic
        telegramTextField.text = telegram ?? ""
        workTextField.text = job ?? ""
        postTextField.text = workPlace ?? ""
        semesterTextField.text = "\(semester)"
        statusLabel.text = isInAcademivLeave ? "В академе" : "Учится"
    }
    
    func updateUserData(name: String, surname: String, patronymic: String?,
                        telegram: String?, from: Date?, to: Date?) {
        nameTextField.text = name
        surnameTextField.text = surname
        patronymicTextField.text = patronymic
        telegramTextField.text = telegram ?? ""
        if let from, let to {
            startDatePicker.date = from
            endDatePicker.date = to
        }
    }
    
    func setupFields() {
        setupWorkTime()
    }
    
    func setupEditButton() {
        let y = tabBarController?.tabBar.frame.minY ?? view.frame.maxY
        editButton = ButtonView(frame: CGRect(x: 25, y: y - 100, width: view.frame.width - 50, height: 45))
        view.addSubview(editButton)
        editButton.setTitle("Редактировать", for: .normal)
        
        editButton.addTarget(self, action: #selector(editProfile), for: .touchUpInside)
    }
    
    func setupSaveButton() {
        let y = tabBarController?.tabBar.frame.minY ?? view.frame.maxY
        saveButton = ButtonView(frame: CGRect(x: 25, y: y - 100, width: view.frame.width - 50, height: 45))
        view.addSubview(saveButton)
        saveButton.setTitle("Сохранить", for: .normal)
        
        saveButton.addTarget(self, action: #selector(saveProfile), for: .touchUpInside)
    }
    
    func setupGradesButton() {
        let y = tabBarController?.tabBar.frame.minY ?? view.frame.maxY
        gradesButton = ButtonView(frame: CGRect(x: 25, y: editButton.frame.minY - 55, width: view.frame.width - 50, height: 45))
        view.addSubview(gradesButton)
        gradesButton.setTitle("Оценки", for: .normal)
        
        gradesButton.addTarget(self, action: #selector(gradesButtonTapped), for: .touchUpInside)
    }
    
    
    func changeEnable(isEdit: Bool) {
        nameTextField.isUserInteractionEnabled = isEdit
        surnameTextField.isUserInteractionEnabled = isEdit
        patronymicTextField.isUserInteractionEnabled = isEdit
        telegramTextField.isUserInteractionEnabled = isEdit
        startDatePicker.isUserInteractionEnabled = isEdit
        endDatePicker.isUserInteractionEnabled = isEdit
        workTextField.isUserInteractionEnabled = isEdit
        postTextField.isUserInteractionEnabled = isEdit
        semesterTextField.isUserInteractionEnabled = isEdit
        statusBackgroundView.isUserInteractionEnabled = isEdit
        
        saveButton.isHidden = !isEdit
        editButton.isHidden = isEdit
        
        if isEdit {
            enableEditMode()
        } else {
            disableEditMode()
        }
    }
}
