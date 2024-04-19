//
//  CourseViewController.swift
//  App1C
//
//  Created by Станислава on 09.04.2024.
//

import UIKit

class CourseViewController: UIViewController {
    private lazy var titleLabel = UILabel()
    private lazy var linksView = UIView()
    private lazy var linksTableView = UITableView()
    private lazy var linksModels: [BaseModel] = [
        BaseModel(id: 0, title: "Преподаватели", image: Images.persons.uiImage),
        BaseModel(id: 1, title: "Студенты", image: Images.persons.uiImage),
        BaseModel(id: 3, title: "Зависимости", image: Images.books.uiImage),
        BaseModel(id: 4, title: "Чат курса", image: Images.chat.uiImage)
    ]
    
    private lazy var dayOfWeekTitle = UILabel()
    private lazy var dayOfWeekView = UIView()
    private lazy var dayOfWeekLabel = UILabel()
    
    private lazy var courseTypeTitle = UILabel()
    private lazy var courseTypeView = UIView()
    private lazy var courseTypeLabel = UILabel()
    
    private lazy var textFieldView = UIView()
    private lazy var descriptionView = UIView()
    private lazy var descriptionTextField = UITextView()
    
    private lazy var saveButton = UIButton()
    private lazy var editButton = UIButton()
    private lazy var addButton = UIButton()
    
    private lazy var addDependenciesLabel = UILabel()
    private lazy var addTeachersLabel = UILabel()
    
    let chatTitle = UILabel()
    private lazy var chatView = UIView()
    private lazy var chatTextField = UITextField()
    
    private lazy var nameView = UIView()
    private lazy var nameTextField = UITextField()
    
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
    
    private var output: CourseViewOutput

    init(output: CourseViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupTitle()
        output.viewIsReady()
//        setupAddDependencies()
//        setupLinksView()
//        setupType()
//        setupTimeTable()
//        setupEditButton()
//        setupSaveButton()
//        setupDescription()
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
        titleLabel = TitleView(frame: CGRect(x: 30, y: 25, width: view.frame.width - 60, height: 30), title: "Добавить курс")
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -30),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25)
        ])
    }
    
    private func setupName() {
        let title = UILabel()
        view.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Название:"
        nameTextField.placeholder = "Введите название курса"
        title.font = .systemFont(ofSize: 18, weight: .semibold)
        title.textColor = .black
        
        view.addSubview(nameView)
        nameView.addSubview(nameTextField)
        nameView.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameView.layer.cornerRadius = 15
        nameView.backgroundColor = .systemGray6

        nameTextField.backgroundColor = .systemGray6
        nameTextField.textColor = .black
        nameTextField.tintColor = .gray
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25),
            title.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            nameView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            
            nameView.heightAnchor.constraint(equalToConstant: 40),
            nameView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            nameView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            nameTextField.leadingAnchor.constraint(equalTo: nameView.leadingAnchor, constant: 15),
            nameTextField.trailingAnchor.constraint(equalTo: nameView.trailingAnchor, constant: -15),
            nameTextField.centerXAnchor.constraint(equalTo: nameView.centerXAnchor),
            nameTextField.centerYAnchor.constraint(equalTo: nameView.centerYAnchor),
        ])
    }
    
    private func setupAddDependencies() {
        createTitle(title: addDependenciesLabel)
        addDependenciesLabel.text = "Добавить зависимости"
        
        let plusButton = UIButton(type: .system)
        plusButton.setImage(Images.plus.uiImage?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 22)), for: .normal)
        plusButton.tintColor = .darkGray
        view.addSubview(plusButton)
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addDependenciesLabel.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 20),
            addDependenciesLabel.widthAnchor.constraint(equalToConstant: 230),
            plusButton.centerYAnchor.constraint(equalTo: addDependenciesLabel.centerYAnchor),
            plusButton.leadingAnchor.constraint(equalTo: addDependenciesLabel.trailingAnchor, constant: 5)
        ])
        
        plusButton.addTarget(self, action: #selector(addDependencies), for: .touchUpInside)
    }
    
    private func setupAddTeachers() {
        createTitle(title: addTeachersLabel)
        addTeachersLabel.text = "Добавить преподавателей"
        
        let plusButton = UIButton(type: .system)
        plusButton.setImage(Images.plus.uiImage?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 22)), for: .normal)
        plusButton.tintColor = .darkGray
        view.addSubview(plusButton)
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addTeachersLabel.topAnchor.constraint(equalTo: addDependenciesLabel.bottomAnchor, constant: 20),
            addTeachersLabel.widthAnchor.constraint(equalToConstant: 230),
            plusButton.centerYAnchor.constraint(equalTo: addTeachersLabel.centerYAnchor),
            plusButton.leadingAnchor.constraint(equalTo: addTeachersLabel.trailingAnchor, constant: 5)
        ])
        
        plusButton.addTarget(self, action: #selector(addTeachers), for: .touchUpInside)
    }
    
    private func setupChat() {
        createTitle(title: chatTitle)
        chatTitle.text = "Чат курса:"
        
        view.addSubview(chatView)
        chatView.addSubview(chatTextField)
        chatView.translatesAutoresizingMaskIntoConstraints = false
        chatTextField.translatesAutoresizingMaskIntoConstraints = false
        chatTextField.placeholder = "t.me/"
        
        chatView.layer.cornerRadius = 15
        chatView.backgroundColor = .systemGray6
        
        chatTextField.textColor = .black
        chatTextField.backgroundColor = .systemGray6
        chatTextField.tintColor = .gray
        
        NSLayoutConstraint.activate([
         //   chatView.topAnchor.constraint(equalTo: addTeachersLabel.bottomAnchor, constant: 20),
            chatTitle.centerYAnchor.constraint(equalTo: chatView.centerYAnchor),
            
            chatView.leadingAnchor.constraint(equalTo: chatTitle.trailingAnchor, constant: 20),
            chatView.heightAnchor.constraint(equalToConstant: 40),
            chatView.widthAnchor.constraint(equalToConstant: 200),
            
            chatTextField.heightAnchor.constraint(equalToConstant: 40),
            chatTextField.widthAnchor.constraint(equalToConstant: 180),
            chatTextField.centerXAnchor.constraint(equalTo: chatView.centerXAnchor),
            chatTextField.centerYAnchor.constraint(equalTo: chatView.centerYAnchor),
        ])
    }
    
    private func setupLinksView() {
        linksTableView.register(BaseCell.self, forCellReuseIdentifier: "BaseCell")
        linksTableView.delegate = self
        linksTableView.dataSource = self
        
        linksView = TableView(
            contentView: view,
            frame: view.frame,
            title: "",
            tableView: linksTableView
        )
        
        linksView.backgroundColor = .white
    //    linksTableView.layer.borderColor = UIColor.clear.cgColor
        
        view.addSubview(linksView)
        linksView.addSubview(linksTableView)
        linksView.translatesAutoresizingMaskIntoConstraints = false
        linksTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            linksTableView.heightAnchor.constraint(equalToConstant: CGFloat(Double(linksModels.count * 50) - 0.5)),
            linksView.heightAnchor.constraint(equalTo: linksTableView.heightAnchor, constant: 30),
            linksView.bottomAnchor.constraint(equalTo: linksTableView.bottomAnchor, constant: 15),
            linksView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0)
        ])
    }
    
    private func setupType() {
        createTitle(title: courseTypeTitle)
        courseTypeTitle.text = "Тип курса:"
        courseTypeLabel.font = .systemFont(ofSize: 15)
        
        view.addSubview(courseTypeView)
        courseTypeView.addSubview(courseTypeLabel)
        courseTypeView.translatesAutoresizingMaskIntoConstraints = false
        courseTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        courseTypeLabel.textAlignment = .center
        
        courseTypeView.layer.cornerRadius = 15
        courseTypeView.backgroundColor = Colors.paleYellow.uiColor
        
        courseTypeLabel.textColor = .black
        courseTypeLabel.text = "Не указан"
        
        NSLayoutConstraint.activate([
            //courseTypeView.topAnchor.constraint(equalTo: linksView.bottomAnchor, constant: 10),
            courseTypeTitle.centerYAnchor.constraint(equalTo: courseTypeView.centerYAnchor),

            courseTypeView.heightAnchor.constraint(equalToConstant: 40),
            courseTypeView.widthAnchor.constraint(equalToConstant: 200),
            
            courseTypeLabel.heightAnchor.constraint(equalToConstant: 40),
            courseTypeLabel.widthAnchor.constraint(equalToConstant: 200),
            courseTypeLabel.centerXAnchor.constraint(equalTo: courseTypeView.centerXAnchor),
            courseTypeLabel.centerYAnchor.constraint(equalTo: courseTypeView.centerYAnchor),
        ])
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showTypesAlert))
        courseTypeView.addGestureRecognizer(gestureRecognizer)
        courseTypeView.isUserInteractionEnabled = true
    }
    
    private func setupTimeTable() {
        let title = UILabel()
        view.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Расписание"
        title.font = .systemFont(ofSize: 18, weight: .semibold)
        title.textColor = .black
        
        createTitle(title: dayOfWeekTitle)
        dayOfWeekTitle.text = "День недели:"
        
        view.addSubview(dayOfWeekView)
        dayOfWeekView.addSubview(dayOfWeekLabel)
        dayOfWeekView.translatesAutoresizingMaskIntoConstraints = false
        dayOfWeekLabel.translatesAutoresizingMaskIntoConstraints = false
        dayOfWeekLabel.textAlignment = .center
        
        dayOfWeekView.layer.cornerRadius = 15
        dayOfWeekView.backgroundColor = .systemGray6
        
        dayOfWeekLabel.textColor = .black
        dayOfWeekLabel.text = "Не указан"
        dayOfWeekLabel.isUserInteractionEnabled = false
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: courseTypeView.bottomAnchor, constant: 20),
            title.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            
            dayOfWeekView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            dayOfWeekTitle.centerYAnchor.constraint(equalTo: dayOfWeekView.centerYAnchor),
            
            dayOfWeekView.leadingAnchor.constraint(equalTo: dayOfWeekTitle.trailingAnchor, constant: 20),
            dayOfWeekView.heightAnchor.constraint(equalToConstant: 34),
            dayOfWeekView.widthAnchor.constraint(equalToConstant: 130),
            
            dayOfWeekLabel.heightAnchor.constraint(equalToConstant: 34),
            dayOfWeekLabel.widthAnchor.constraint(equalToConstant: 130),
            dayOfWeekLabel.centerXAnchor.constraint(equalTo: dayOfWeekView.centerXAnchor),
            dayOfWeekLabel.centerYAnchor.constraint(equalTo: dayOfWeekView.centerYAnchor),
        ])
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showDaysOfWeekAlert))
        dayOfWeekView.addGestureRecognizer(gestureRecognizer)
        dayOfWeekView.isUserInteractionEnabled = true
    
        let workTimeTitle = UILabel()
        createTitle(title: workTimeTitle)
        workTimeTitle.text = "Время:"
        
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
        createDatePicker(datePicker: startDatePicker, hour: 0, minute: 0)
        createDatePicker(datePicker: endDatePicker, hour: 0, minute: 0)

        
        NSLayoutConstraint.activate([
            workTimeTitle.topAnchor.constraint(equalTo: dayOfWeekView.bottomAnchor, constant: 20),
            startDatePicker.heightAnchor.constraint(equalToConstant: 40),
            endDatePicker.heightAnchor.constraint(equalToConstant: 40),
            startDatePicker.centerYAnchor.constraint(equalTo: workTimeTitle.centerYAnchor),
            endDatePicker.centerYAnchor.constraint(equalTo: workTimeTitle.centerYAnchor),
            separatorLabel.centerYAnchor.constraint(equalTo: workTimeTitle.centerYAnchor),
            startDatePicker.leadingAnchor.constraint(equalTo: workTimeTitle.trailingAnchor, constant: 25),
            separatorLabel.leadingAnchor.constraint(equalTo: startDatePicker.trailingAnchor, constant: 5),
            endDatePicker.leadingAnchor.constraint(equalTo: separatorLabel.trailingAnchor, constant: 5)
        ])
    }
    
    @objc private func showDaysOfWeekAlert() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        addAlertAction(title: "Понедельник", alert: alertController, label: dayOfWeekLabel)
        addAlertAction(title: "Вторник", alert: alertController, label: dayOfWeekLabel)
        addAlertAction(title: "Среда", alert: alertController, label: dayOfWeekLabel)
        addAlertAction(title: "Четверг", alert: alertController, label: dayOfWeekLabel)
        addAlertAction(title: "Пятница", alert: alertController, label: dayOfWeekLabel)
        addAlertAction(title: "Суббота", alert: alertController, label: dayOfWeekLabel)
        alertController.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        alertController.view.backgroundColor = Colors.yellow.uiColor
        alertController.view.tintColor = .black
        alertController.view.layer.cornerRadius = 15
        present(alertController, animated: true)
    }
    
    @objc private func showTypesAlert() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        addAlertAction(title: "Кафедральный", alert: alertController, label: courseTypeLabel)
        addAlertAction(title: "Самостоятельная работа", alert: alertController, label: courseTypeLabel)
        addAlertAction(title: "Несколько занятий", alert: alertController, label: courseTypeLabel)
        addAlertAction(title: "EPR", alert: alertController, label: courseTypeLabel)
        addAlertAction(title: "Онлайн-курс во ВШЭ", alert: alertController, label: courseTypeLabel)
        addAlertAction(title: "Практический курс", alert: alertController, label: courseTypeLabel)
        alertController.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        alertController.view.backgroundColor = Colors.yellow.uiColor
        alertController.view.tintColor = .black
        alertController.view.layer.cornerRadius = 15
        present(alertController, animated: true)
    }
    
    private func addAlertAction(title: String, alert: UIAlertController, label: UILabel) {
        alert.addAction(UIAlertAction(title: title, style: .default) {_ in
            label.text = title
        })
    }
    
    private func createTitle(title: UILabel) {
        view.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = .black
        title.font = .systemFont(ofSize: 17, weight: .regular)
        
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50)
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
    
    private func setupDescription() {
        let title = UILabel()
        descriptionView.addSubview(textFieldView)
        view.addSubview(descriptionView)
        descriptionView.addSubview(title)
        textFieldView.addSubview(descriptionTextField)
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        textFieldView.translatesAutoresizingMaskIntoConstraints = false
        
        title.font = .systemFont(ofSize: 18, weight: .semibold)
        title.textColor = .black
        title.text = "Описание"
        
        descriptionTextField.backgroundColor = .clear
        descriptionTextField.textColor = .black
        descriptionTextField.text = ""
        descriptionTextField.textContainer.maximumNumberOfLines = 0
        descriptionTextField.font = .systemFont(ofSize: 15, weight: .regular)
        descriptionTextField.textAlignment = .justified
        descriptionTextField.tintColor = .gray
        
        textFieldView.backgroundColor = .systemGray6
        textFieldView.layer.cornerRadius = 15
        
        NSLayoutConstraint.activate([
            //descriptionView.topAnchor.constraint(equalTo: startDatePicker.bottomAnchor, constant: 20),
            descriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descriptionView.heightAnchor.constraint(equalToConstant: 140),
            
            title.topAnchor.constraint(equalTo: descriptionView.topAnchor),
            title.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor, constant: 20),
            
            textFieldView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
            textFieldView.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor, constant: 10),
            textFieldView.trailingAnchor.constraint(equalTo: descriptionView.trailingAnchor, constant: -10),
            textFieldView.bottomAnchor.constraint(lessThanOrEqualTo: descriptionView.bottomAnchor, constant: -10),
            
            descriptionTextField.topAnchor.constraint(equalTo: textFieldView.topAnchor, constant: 2),
            descriptionTextField.bottomAnchor.constraint(equalTo: textFieldView.bottomAnchor, constant: -10),
            descriptionTextField.leadingAnchor.constraint(equalTo: textFieldView.leadingAnchor, constant: 10),
            descriptionTextField.trailingAnchor.constraint(equalTo: textFieldView.trailingAnchor, constant: -5),
        ])
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
    
    func setupAddButton() {
        let y = tabBarController?.tabBar.frame.minY ?? view.frame.maxY
        addButton = ButtonView(frame: CGRect(x: 25, y: y - 100, width: view.frame.width - 50, height: 45))
        view.addSubview(addButton)
        addButton.setTitle("Добавить", for: .normal)
        
        addButton.addTarget(self, action: #selector(addProfile), for: .touchUpInside)
    }
    
    private func getType() -> String {
        let type = courseTypeLabel.text
        switch type {
        case "Кафедральный":
            return CourseType.department.rawValue
        case "Самостоятельная работа":
            return CourseType.ownWork.rawValue
        case "Несколько занятий":
            return CourseType.coupleOfLessons.rawValue
        case "EPR":
            return CourseType.epr.rawValue
        case "Онлайн-курс во ВШЭ":
            return CourseType.hse.rawValue
        case "Практический курс":
            return CourseType.practise.rawValue
        default:
            return "Не указан"
        }
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func addDependencies() {
        output.addDepsButtonTapped()
    }
    
    @objc func addTeachers() {
        output.addTeachersButtonTapped()
    }
    
    @objc func editProfile() {
        output.editButtonTapped()
    }
    
    @objc func saveProfile() {
        output.saveButtonTapped()
    }
    
    @objc func addProfile() {
        output.addButtonTapped(
            name: nameTextField.text ?? "",
            chat: chatTextField.text ?? "",
            type: getType(),
            descr: descriptionTextField.text ?? ""
        )
    }
}

extension CourseViewController: CourseViewInput {
    func setupAddMode() {
        setupName()
        setupAddDependencies()
        setupAddTeachers()
        setupChat()
        setupType()
        setupDescription()
        setupAddButton()
        
        NSLayoutConstraint.activate([
            chatView.topAnchor.constraint(equalTo: addTeachersLabel.bottomAnchor, constant: 20),
            courseTypeView.leadingAnchor.constraint(equalTo: chatView.leadingAnchor, constant: 0),
            courseTypeView.topAnchor.constraint(equalTo: chatView.bottomAnchor, constant: 20),
            descriptionView.topAnchor.constraint(equalTo: courseTypeView.bottomAnchor, constant: 20),
        ])
        
        chatTextField.isUserInteractionEnabled = true
        courseTypeView.isUserInteractionEnabled = true
        descriptionTextField.isUserInteractionEnabled = true
        textFieldView.backgroundColor = .systemGray6
    }
    
    func setupEditMode() {
        setupName()
        setupChat()
        setupType()
        setupTimeTable()
        setupDescription()
        setupSaveButton()
        
        NSLayoutConstraint.activate([
            chatView.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 20),
            courseTypeView.leadingAnchor.constraint(equalTo: chatView.leadingAnchor, constant: 0),
            courseTypeView.topAnchor.constraint(equalTo: chatView.bottomAnchor, constant: 20),
            descriptionView.topAnchor.constraint(equalTo: startDatePicker.bottomAnchor, constant: 20),
        ])
        
        titleLabel.text = "Редактирование"
        chatTextField.isUserInteractionEnabled = true
        courseTypeView.isUserInteractionEnabled = true
        descriptionTextField.isUserInteractionEnabled = true
        textFieldView.backgroundColor = .systemGray6
        startDatePicker.isUserInteractionEnabled = true
        endDatePicker.isUserInteractionEnabled = true
        dayOfWeekView.isUserInteractionEnabled = true
    }
    
    func setupReadMode() {
        setupLinksView()
        setupType()
        setupTimeTable()
        setupDescription()
        
        NSLayoutConstraint.activate([
            courseTypeView.topAnchor.constraint(equalTo: linksView.bottomAnchor, constant: 10),
            courseTypeView.leadingAnchor.constraint(equalTo: courseTypeTitle.trailingAnchor, constant: 20),
            descriptionView.topAnchor.constraint(equalTo: startDatePicker.bottomAnchor, constant: 20),
        ])
        
        chatTextField.isUserInteractionEnabled = false
        courseTypeView.isUserInteractionEnabled = false
        descriptionTextField.isUserInteractionEnabled = false
        textFieldView.backgroundColor = .white
        dayOfWeekView.backgroundColor = .white
        startDatePicker.isUserInteractionEnabled = false
        endDatePicker.isUserInteractionEnabled = false
        dayOfWeekView.isUserInteractionEnabled = false
    }
    
    func setTitle(title: String) {
        titleLabel.text = title
    }
    
    func updateData(name: String, chat: String, type: String, dayOfWeek: String,
                    from: Date, to: Date, descr: String) {
        
    }
    
    func addEditButton() {
        setupEditButton()
    }
    
    func close() {
        goBack()
    }
}

extension CourseViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return linksModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BaseCell", for: indexPath) as? BaseCell else {
            fatalError("Cannot create BaseCell")
        }
        cell.configure(with: linksModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //   output.selectedRowAt(index: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}



