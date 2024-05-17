//
//  ThemeSelectionEventViewController.swift
//  App1C
//
//  Created by Станислава on 05.05.2024.
//

import UIKit

class ThemeSelectionEventViewController: UIViewController {
    private lazy var titleLabel = UILabel()
    private lazy var descriptionTextField = UITextField()
    private lazy var themesTextField = UITextField()
    private lazy var deadlineLabel = UILabel()
    private lazy var textFieldView = UIView()
    private lazy var messageLabel = UILabel()
    
    private lazy var scrollView = UIScrollView()
    
    let commonDeadlineDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.tintColor = Colors.red.uiColor
        datePicker.locale = Locale(identifier: "ru_RU")
        return datePicker
    }()
    
    let ownDeadlineDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.tintColor = Colors.red.uiColor
        datePicker.locale = Locale(identifier: "ru_RU")
        return datePicker
    }()
    
    let departmentDeadlineDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.tintColor = Colors.red.uiColor
        datePicker.locale = Locale(identifier: "ru_RU")
        return datePicker
    }()
    
    let workDeadlineDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.tintColor = Colors.red.uiColor
        datePicker.locale = Locale(identifier: "ru_RU")
        return datePicker
    }()
    
    private var output: ThemeSelectionEventViewOutput
        
    init(output: ThemeSelectionEventViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
        updateDatePickers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        updateDatePickers()
        setupTitle()
        setupURLs()
        setupDeadline()
        updateDatePickers()
        output.viewIsReady()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true
        updateDatePickers()
        (navigationController as? CustomNavigationController)?.setupBackButton()
        (navigationController as? CustomNavigationController)?.backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
        tabBarController?.tabBar.isTranslucent = true
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        (navigationController as? CustomNavigationController)?.hideBackButton()
    }
    
    override func viewDidLayoutSubviews() {
        updateDatePickers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateDatePickers()
    }
    
    private func setupTitle() {
        titleLabel = TitleView(frame: CGRect(x: 30, y: 25, width: view.frame.width, height: 30), title: "Выбор темы диплома")
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -30),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25)
        ])
    }
    
    private func setupURLs() {
        let descrTitle = UILabel()
        descrTitle.text = "Описание:"
        descriptionTextField.placeholder = "Укажите ссылку"
        createURLView(title: descrTitle, textField: descriptionTextField)
        
        let themesTitle = UILabel()
        themesTitle.text = "Список тем от кафедры:"
        themesTextField.placeholder = "Укажите ссылку"
        createURLView(title: themesTitle, textField: themesTextField)

        NSLayoutConstraint.activate([
            descrTitle.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25),
            themesTitle.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor, constant: 20),
        ])
    }
    
    private func createURLView(title: UILabel, textField: UITextField) {
        view.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = .systemFont(ofSize: 18, weight: .semibold)
        title.textColor = .black
        
        view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .black
        textField.tintColor = .darkGray
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        
        let imageView = UIImageView(image: Images.link.uiImage)
        imageView.tintColor = .darkGray
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            imageView.leadingAnchor.constraint(equalTo: title.leadingAnchor, constant: -10),
            imageView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            imageView.heightAnchor.constraint(equalToConstant: 20),
            imageView.widthAnchor.constraint(equalToConstant: 20),
            textField.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            textField.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
    
    private func setupDeadline() {
        view.addSubview(deadlineLabel)
        deadlineLabel.translatesAutoresizingMaskIntoConstraints = false
        deadlineLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        deadlineLabel.textColor = .black
        deadlineLabel.text = "Дедлайны: "
        
        let commonDeadlineTitle = UILabel()
        commonDeadlineTitle.text = "Общий дедлайн:"
        createDeadline(title: commonDeadlineTitle, datePicker: commonDeadlineDatePicker)
        
        let ownDeadlineTitle = UILabel()
        ownDeadlineTitle.text = "Дедлайн по своей\nтеме:"
        createDeadline(title: ownDeadlineTitle, datePicker: ownDeadlineDatePicker)
        
        let departmentDeadlineTitle = UILabel()
        departmentDeadlineTitle.text = "Дедлайн по теме от кафедры:"
        createDeadline(title: departmentDeadlineTitle, datePicker: departmentDeadlineDatePicker)
        
        let workDeadlineTitle = UILabel()
        workDeadlineTitle.text = "Дедлайн по теме от работы:"
        createDeadline(title: workDeadlineTitle, datePicker: workDeadlineDatePicker)
        
        NSLayoutConstraint.activate([
            deadlineLabel.topAnchor.constraint(equalTo: themesTextField.bottomAnchor, constant: 25),
            deadlineLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            commonDeadlineDatePicker.topAnchor.constraint(equalTo: deadlineLabel.bottomAnchor, constant: 10),
            ownDeadlineDatePicker.topAnchor.constraint(equalTo: commonDeadlineDatePicker.bottomAnchor, constant: 20),
            departmentDeadlineDatePicker.topAnchor.constraint(equalTo: ownDeadlineDatePicker.bottomAnchor, constant: 20),
            workDeadlineDatePicker.topAnchor.constraint(equalTo: departmentDeadlineDatePicker.bottomAnchor, constant: 20)
        ])
    }
    
    private func createDeadline(title: UILabel, datePicker: UIDatePicker) {
        view.addSubview(title)
        view.addSubview(datePicker)
        title.translatesAutoresizingMaskIntoConstraints = false
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        title.font = .systemFont(ofSize: 17, weight: .regular)
        title.numberOfLines = 2
        title.textColor = .black
        title.textAlignment = .justified
        
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            title.widthAnchor.constraint(equalToConstant: 145),
            title.centerYAnchor.constraint(equalTo: datePicker.centerYAnchor),
            datePicker.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: 8)
        ])
        
        updateDatePicker(datePicker: datePicker)
        //datePicker.isUserInteractionEnabled = false
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        datePicker.date = Date.now
    }
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        updateDatePicker(datePicker: sender)
    }
    
    private func updateDatePickers() {
        updateDatePicker(datePicker: commonDeadlineDatePicker)
        updateDatePicker(datePicker: ownDeadlineDatePicker)
        updateDatePicker(datePicker: departmentDeadlineDatePicker)
        updateDatePicker(datePicker: workDeadlineDatePicker)
    }
    
    private func updateDatePicker(datePicker: UIDatePicker) {
        for subView in datePicker.subviews {
            subView.layer.cornerRadius = 15
            for views in subView.subviews {
                views.backgroundColor = Colors.paleYellow.uiColor
                views.layer.cornerRadius = 15
                for sub in views.subviews {
                    sub.backgroundColor = Colors.paleYellow.uiColor
                    sub.layer.cornerRadius = 15
                    for subV in sub.subviews {
                        subV.backgroundColor = Colors.paleYellow.uiColor
                        subV.layer.cornerRadius = 15
                        for subVi in subV.subviews {
                            subVi.backgroundColor = Colors.paleYellow.uiColor
                            subVi.layer.cornerRadius = 15
                            for subVie in subVi.subviews {
                                subVie.backgroundColor = Colors.paleYellow.uiColor
                                subVie.layer.cornerRadius = 15
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func setupCreateButton() {
        let y = tabBarController?.tabBar.frame.minY ?? view.frame.maxY
        let createButton = ButtonView(frame: CGRect(x: 25, y: y - 100, width: view.frame.width - 50, height: 45))
        view.addSubview(createButton)
        createButton.setTitle("Создать", for: .normal)
        createButton.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
    }
    
    private func setupSaveButton() {
        let y = tabBarController?.tabBar.frame.minY ?? view.frame.maxY
        let saveButton = ButtonView(frame: CGRect(x: 25, y: y - 100, width: view.frame.width - 50, height: 45))
        view.addSubview(saveButton)
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    func changeEditEnable(edit: Bool) {
        commonDeadlineDatePicker.isUserInteractionEnabled = edit
        ownDeadlineDatePicker.isUserInteractionEnabled = edit
        workDeadlineDatePicker.isUserInteractionEnabled = edit
        departmentDeadlineDatePicker.isUserInteractionEnabled = edit
        descriptionTextField.isUserInteractionEnabled = edit
        themesTextField.isUserInteractionEnabled = edit
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func createButtonTapped() {
        let model = ThemeSelectionEventModel(
            descrURL: descriptionTextField.text,
            themesURL: themesTextField.text,
            commonDeadline: commonDeadlineDatePicker.date,
            ownDeadline: ownDeadlineDatePicker.date,
            departmentDeadline: departmentDeadlineDatePicker.date,
            workDeadline: workDeadlineDatePicker.date
        )
        output.createButtonTapped(model: model)
    }
    
    @objc private func saveButtonTapped() {
        let model = ThemeSelectionEventModel(
            descrURL: descriptionTextField.text,
            themesURL: themesTextField.text,
            commonDeadline: commonDeadlineDatePicker.date,
            ownDeadline: ownDeadlineDatePicker.date,
            departmentDeadline: departmentDeadlineDatePicker.date,
            workDeadline: workDeadlineDatePicker.date
        )
        output.saveButtonTapped(model: model)
    }
}

extension ThemeSelectionEventViewController: ThemeSelectionEventViewInput {
    
    func setupCreateMode() {
        setupCreateButton()
        changeEditEnable(edit: true)
    }
    
    func setupSaveMode() {
        setupSaveButton()
        changeEditEnable(edit: true)
    }
    
    func setupReadMode() {
        changeEditEnable(edit: false)
    }
    
    func updateData(model: ThemeSelectionEventModel, isEdit: Bool) {
        commonDeadlineDatePicker.date = model.commonDeadline
        ownDeadlineDatePicker.date = model.ownDeadline
        departmentDeadlineDatePicker.date = model.departmentDeadline
        workDeadlineDatePicker.date = model.workDeadline
        
        if let descrURL = model.descrURL {
            descriptionTextField.text = isEdit ? descrURL : "Ссылка на описание"
            descriptionTextField.textColor = isEdit ? .black : .systemBlue
        } else {
            descriptionTextField.text = isEdit ? "" : "Не указана"
            descriptionTextField.textColor = .black
        }
        
        if let themesURL = model.themesURL {
            themesTextField.text = isEdit ? themesURL : "Ссылка на список тем"
            themesTextField.textColor = isEdit ? .black : .systemBlue
        } else {
            themesTextField.text = isEdit ? "" : "Не указана"
            themesTextField.textColor = .black
        }
        
        updateDatePickers()
    }
  
    func close() {
        goBack()
    }
}
