//
//  EventViewController.swift
//  App1C
//
//  Created by Станислава on 16.04.2024.
//

import UIKit

class EventViewController: UIViewController {
    private lazy var titleLabel = UILabel()
    private lazy var descriptionView = UIView()
    private lazy var descriptionTextField = UITextView()
    private lazy var deadlineLabel = UILabel()
    private lazy var textFieldView = UIView()
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.tintColor = Colors.red.uiColor
        datePicker.locale = Locale(identifier: "ru_RU")
        return datePicker
    }()
    
    private var output: EventViewOutput
        
    init(output: EventViewOutput) {
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
        setupDeadline()
        setupDescription()
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
        titleLabel = TitleView(frame: CGRect(x: 30, y: 25, width: view.frame.width, height: 30), title: "Выбор кусров")
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -30),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25)
        ])
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
            deadlineLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25),
            deadlineLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            datePicker.centerYAnchor.constraint(equalTo: deadlineLabel.centerYAnchor),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
        
        for subView in datePicker.subviews {
            for view in subView.subviews {
                view.backgroundColor = Colors.paleYellow.uiColor
                view.layer.cornerRadius = 15
                for sub in view.subviews {
                    sub.backgroundColor = Colors.paleYellow.uiColor
                    sub.layer.cornerRadius = 15
                }
            }
        }
        datePicker.isUserInteractionEnabled = false
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
    }
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        for subView in datePicker.subviews {
            for view in subView.subviews {
                view.backgroundColor = Colors.paleYellow.uiColor
                view.layer.cornerRadius = 15
                for sub in view.subviews {
                    sub.backgroundColor = Colors.paleYellow.uiColor
                    view.layer.cornerRadius = 15
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
        
        textFieldView.backgroundColor = .white
        textFieldView.layer.cornerRadius = 15
        
        NSLayoutConstraint.activate([
            descriptionView.topAnchor.constraint(equalTo: deadlineLabel.bottomAnchor, constant: 25),
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
    
    private func setupCreateButton() {
        let y = tabBarController?.tabBar.frame.minY ?? view.frame.maxY
        let createButton = ButtonView(frame: CGRect(x: 25, y: y - 100, width: view.frame.width - 50, height: 45))
        view.addSubview(createButton)
        createButton.setTitle("Создать", for: .normal)
        createButton.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
    }
    
    private func setupGoOverButton() {
        let y = tabBarController?.tabBar.frame.minY ?? view.frame.maxY
        let goOverButton = ButtonView(frame: CGRect(x: 25, y: y - 100, width: view.frame.width - 50, height: 45))
        view.addSubview(goOverButton)
        goOverButton.setTitle("Перейти", for: .normal)
        goOverButton.addTarget(self, action: #selector(goOverButtonTapped), for: .touchUpInside)
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
        output.createButtonTapped(deadline: datePicker.date, descr: descriptionTextField.text ?? "")
    }
    
    @objc private func goOverButtonTapped() {
        output.goOverButtonTapped()
    }
    
    @objc private func saveButtonTapped() {
        output.saveButtonTapped(deadline: datePicker.date, descr: descriptionTextField.text ?? "")
    }
}

extension EventViewController: EventViewInput {
    func setTitle(title: String) {
        titleLabel.text = title
    }
    
    func setupCreateMode() {
        setupCreateButton()
        datePicker.isUserInteractionEnabled = true
        descriptionTextField.isUserInteractionEnabled = true
        textFieldView.backgroundColor = .systemGray6
    }
    
    func setupSaveMode() {
        setupSaveButton()
        datePicker.isUserInteractionEnabled = true
        descriptionTextField.isUserInteractionEnabled = true
        textFieldView.backgroundColor = .systemGray6
    }
    
    func close() {
        goBack()
    }
}
