//
//  DiplomaSpeechEventViewController.swift
//  App1C
//
//  Created by Станислава on 05.05.2024.
//

import Foundation
import UIKit

class DiplomaSpeechEventViewController: UIViewController {
    private lazy var titleLabel = UILabel()
    private lazy var descriptionView = UIView()
    private lazy var descriptionTextField = UITextView()
    private lazy var deadlineLabel = UILabel()
    private lazy var textFieldView = UIView()
    private lazy var messageLabel = UILabel()
    private lazy var typeLabel = UILabel()
    private lazy var typeView = UIView()
    private lazy var timetableTextField = UITextField()
    private lazy var conferenceTextField = UITextField()
    
    private lazy var scrollView = UIScrollView()

    private lazy var coursesView = UIView()
    private lazy var coursesTableView = UITableView()
    private lazy var courses: [CourseModel] = []
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.tintColor = Colors.red.uiColor
        datePicker.locale = Locale(identifier: "ru_RU")
        return datePicker
    }()
    
    private var output: DiplomaSpeechEventViewOutput
        
    init(output: DiplomaSpeechEventViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
        updateDatePicker()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupTitle()
        setupType()
        setupDeadline()
        setupURLs()
        setupDescription()
        output.viewIsReady()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateDatePicker()
        navigationItem.hidesBackButton = true
        (navigationController as? CustomNavigationController)?.setupBackButton()
        (navigationController as? CustomNavigationController)?.backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
        tabBarController?.tabBar.isTranslucent = true
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        updateDatePicker()
        (navigationController as? CustomNavigationController)?.hideBackButton()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        updateDatePicker()
    }
    
    override func beginAppearanceTransition(_ isAppearing: Bool, animated: Bool) {
        super.beginAppearanceTransition(isAppearing, animated: animated)
        updateDatePicker()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateDatePicker()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillLayoutSubviews()
        updateDatePicker()
    }
    
    private func setupTitle() {
        titleLabel = TitleView(frame: CGRect(x: 30, y: 25, width: view.frame.width, height: 30), title: "Контроль НИР\nПредзащита / Защита")
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -30),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25)
        ])
    }
    
    private func setupType() {
        let typeTitle = UILabel()
        view.addSubview(typeTitle)
        typeTitle.translatesAutoresizingMaskIntoConstraints = false
        typeTitle.font = .systemFont(ofSize: 18, weight: .semibold)
        typeTitle.textColor = .black
        typeTitle.text = "Тип события:"
        
        view.addSubview(typeView)
        typeView.addSubview(typeLabel)
        typeView.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.textAlignment = .center
        
        typeView.layer.cornerRadius = 15
        typeView.backgroundColor = Colors.paleYellow.uiColor
        
        typeLabel.textColor = .black
        typeLabel.text = "Не указан"
        
        NSLayoutConstraint.activate([
            typeTitle.centerYAnchor.constraint(equalTo: typeView.centerYAnchor),
            typeTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),

            typeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            typeView.heightAnchor.constraint(equalToConstant: 40),
            typeView.widthAnchor.constraint(equalToConstant: 200),
            typeView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25),
            
            typeLabel.heightAnchor.constraint(equalToConstant: 40),
            typeLabel.widthAnchor.constraint(equalToConstant: 200),
            typeLabel.centerXAnchor.constraint(equalTo: typeView.centerXAnchor),
            typeLabel.centerYAnchor.constraint(equalTo: typeView.centerYAnchor),
        ])
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showTypesAlert))
        typeView.addGestureRecognizer(gestureRecognizer)
        typeView.isUserInteractionEnabled = true
    }
    
    
    private func setupDeadline() {
        view.addSubview(deadlineLabel)
        view.addSubview(datePicker)
        deadlineLabel.translatesAutoresizingMaskIntoConstraints = false
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        deadlineLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        deadlineLabel.textColor = .black
        deadlineLabel.text = "Дедлайн: "
        
        NSLayoutConstraint.activate([
            deadlineLabel.topAnchor.constraint(equalTo: typeView.bottomAnchor, constant: 25),
            deadlineLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            datePicker.centerYAnchor.constraint(equalTo: deadlineLabel.centerYAnchor),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
        
        updateDatePicker()
      //  datePicker.isUserInteractionEnabled = false
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
    }
    
    private func setupURLs() {
        let timeTableTitle = UILabel()
        timeTableTitle.text = "Ссылка на расписание:"
        timetableTextField.placeholder = "Укажите ссылку"
        createURLView(title: timeTableTitle, textField: timetableTextField)
        
        let conferenceTitle = UILabel()
        conferenceTitle.text = "Ссылка на конференцию:"
        conferenceTextField.placeholder = "Укажите ссылку"
        createURLView(title: conferenceTitle, textField: conferenceTextField)

        NSLayoutConstraint.activate([
            timeTableTitle.topAnchor.constraint(equalTo: deadlineLabel.bottomAnchor, constant: 30),
            conferenceTitle.topAnchor.constraint(equalTo: timetableTextField.bottomAnchor, constant: 20),
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
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        updateDatePicker()
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
        descriptionTextField.font = .systemFont(ofSize: 16, weight: .regular)
        descriptionTextField.textAlignment = .justified
        descriptionTextField.tintColor = .gray
        
        textFieldView.backgroundColor = .white
        textFieldView.layer.cornerRadius = 15
        
        NSLayoutConstraint.activate([
            descriptionView.topAnchor.constraint(equalTo: conferenceTextField.bottomAnchor, constant: 25),
            descriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descriptionView.heightAnchor.constraint(equalToConstant: 200),
            
            title.topAnchor.constraint(equalTo: descriptionView.topAnchor),
            title.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor, constant: 10),
            
            textFieldView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
            textFieldView.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor, constant: 5),
            textFieldView.trailingAnchor.constraint(equalTo: descriptionView.trailingAnchor, constant: -10),
            textFieldView.bottomAnchor.constraint(lessThanOrEqualTo: descriptionView.bottomAnchor, constant: -10),
            
            descriptionTextField.topAnchor.constraint(equalTo: textFieldView.topAnchor, constant: 2),
            descriptionTextField.bottomAnchor.constraint(equalTo: textFieldView.bottomAnchor, constant: -10),
            descriptionTextField.leadingAnchor.constraint(equalTo: textFieldView.leadingAnchor, constant: 5),
            descriptionTextField.trailingAnchor.constraint(equalTo: textFieldView.trailingAnchor, constant: -5),
        ])
    }
    
    @objc private func showTypesAlert() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        addAlertAction(title: SpeechType.rw1.title, alert: alertController, label: typeLabel)
        addAlertAction(title: SpeechType.rw2.title, alert: alertController, label: typeLabel)
        addAlertAction(title: SpeechType.rw3.title, alert: alertController, label: typeLabel)
        addAlertAction(title: SpeechType.predefending.title, alert: alertController, label: typeLabel)
        addAlertAction(title: SpeechType.defending.title, alert: alertController, label: typeLabel)
       
        alertController.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        alertController.view.backgroundColor = Colors.yellow.uiColor
        alertController.view.tintColor = .black
        alertController.view.layer.cornerRadius = 15
        updateDatePicker()

        present(alertController, animated: true)
    }
    
    private func addAlertAction(title: String, alert: UIAlertController, label: UILabel) {
        alert.addAction(UIAlertAction(title: title, style: .default) { _ in
            label.text = title
        })
    }
    
    private func updateDatePicker() {
//        for subView in datePicker.subviews {
//            for views in subView.subviews {
//                views.backgroundColor = Colors.paleYellow.uiColor
//                views.layer.cornerRadius = 15
//                for sub in views.subviews {
//                    sub.backgroundColor = Colors.paleYellow.uiColor
//                    sub.layer.cornerRadius = 15
//                    for subV in sub.subviews {
//                        subV.backgroundColor = Colors.paleYellow.uiColor
//                        subV.layer.cornerRadius = 15
//                        for subVi in subV.subviews {
//                            subVi.backgroundColor = Colors.paleYellow.uiColor
//                            subVi.layer.cornerRadius = 15
//                        }
//                    }
//                }
//            }
//        }
//        view.setNeedsLayout()
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
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func createButtonTapped() {
        let model = DiplomaSpeechEventModel(
            type: getType(),
            deadline: datePicker.date,
            timetableURL: timetableTextField.text,
            conferenceURL: conferenceTextField.text,
            description: descriptionTextField.text ?? ""
        )
        output.createButtonTapped(model: model)
    }
    
    func getType() -> SpeechType {
        switch typeLabel.text {
        case SpeechType.rw1.title:
            return .rw1
        case SpeechType.rw1.title:
            return .rw2
        case SpeechType.rw1.title:
            return .rw3
        case SpeechType.rw1.title:
            return .predefending
        case SpeechType.rw1.title:
            return .defending
        default:
            return .rw1
        }
    }
  
    @objc private func saveButtonTapped() {
        let model = DiplomaSpeechEventModel(
            type: getType(),
            deadline: datePicker.date,
            timetableURL: timetableTextField.text,
            conferenceURL: conferenceTextField.text,
            description: descriptionTextField.text ?? ""
        )
        output.saveButtonTapped(model: model)
    }
    
    func changeEditEnable(edit: Bool) {
        datePicker.isUserInteractionEnabled = edit
        descriptionTextField.isUserInteractionEnabled = edit
        conferenceTextField.isUserInteractionEnabled = edit
        timetableTextField.isUserInteractionEnabled = edit
        textFieldView.backgroundColor = edit ? .systemGray6 : .white
    }
}

extension DiplomaSpeechEventViewController: DiplomaSpeechEventViewInput {
    
    func setTitle(title: String) {
        titleLabel.text = title
    }
    
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
    
    func updateData(model: DiplomaSpeechEventModel, isEdit: Bool) {
        datePicker.date = model.deadline
        descriptionTextField.text = model.description
        typeLabel.text = model.type.title
        
        if let timetableURL = model.timetableURL {
            timetableTextField.text = isEdit ? timetableURL : "Ссылка на расписание"
            timetableTextField.textColor = isEdit ? .black : .systemBlue
        } else {
            timetableTextField.text = isEdit ? "" : "Не указана"
            timetableTextField.textColor = .black
        }
        
        if let conferenceURL = model.conferenceURL {
            conferenceTextField.text = isEdit ? conferenceURL : "Ссылка на конференцию"
            conferenceTextField.textColor = isEdit ? .black : .systemBlue
        } else {
            conferenceTextField.text = isEdit ? "" : "Не указана"
            conferenceTextField.textColor = .black
        }
        
        updateDatePicker()
    }
    
    func close() {
        goBack()
    }
}
