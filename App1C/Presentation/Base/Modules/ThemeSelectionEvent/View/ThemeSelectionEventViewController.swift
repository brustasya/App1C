//
//  ThemeSelectionEventViewController.swift
//  App1C
//
//  Created by Станислава on 05.05.2024.
//

import UIKit

class ThemeSelectionEventViewController: UIViewController {
    private lazy var titleLabel = UILabel()
    private lazy var descriptionView = UIView()
    private lazy var descriptionTextField = UITextView()
    private lazy var deadlineLabel = UILabel()
    private lazy var textFieldView = UIView()
    private lazy var messageLabel = UILabel()
    
    private lazy var scrollView = UIScrollView()
    
    let datePicker: UIDatePicker = {
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
        updateDatePicker()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupTitle()
        setupDeadline()
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
    
    override func viewWillLayoutSubviews() {
        updateDatePicker()
    }
    override func viewDidAppear(_ animated: Bool) {
        updateDatePicker()
    }
    
    private func setupTitle() {
        titleLabel = TitleView(frame: CGRect(x: 30, y: 25, width: view.frame.width, height: 30), title: "")
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
        descriptionTextField.placeholder = "Введите название курса"
        title.font = .systemFont(ofSize: 18, weight: .semibold)
        title.textColor = .black
        
        view.addSubview(descriptionView)
        descriptionView.addSubview(descriptionTextField)
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        descriptionView.layer.cornerRadius = 15
        descriptionView.backgroundColor = .systemGray6

        descriptionTextField.backgroundColor = .systemGray6
        descriptionTextField.textColor = .black
        descriptionTextField.tintColor = .gray
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25),
            title.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            descriptionView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            
            descriptionView.heightAnchor.constraint(equalToConstant: 40),
            descriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            descriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            descriptionTextField.heightAnchor.constraint(equalToConstant: 40),
            descriptionTextField.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor, constant: 15),
            descriptionTextField.trailingAnchor.constraint(equalTo: descriptionView.trailingAnchor, constant: -15),
            descriptionTextField.centerXAnchor.constraint(equalTo: descriptionView.centerXAnchor),
            descriptionTextField.centerYAnchor.constraint(equalTo: descriptionView.centerYAnchor),
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
        
        updateDatePicker()
        datePicker.isUserInteractionEnabled = false
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
    }
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        updateDatePicker()
    }
    
    private func updateDatePicker() {
        for subView in datePicker.subviews {
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
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func createButtonTapped() {
        output.createButtonTapped(deadline: datePicker.date, descr: descriptionTextField.text ?? "")
    }
    
    @objc private func saveButtonTapped() {
        output.saveButtonTapped(deadline: datePicker.date, descr: descriptionTextField.text ?? "")
    }
}

extension ThemeSelectionEventViewController: ThemeSelectionEventViewInput {
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
    
    func setupReadMode() {
        datePicker.isUserInteractionEnabled = false
        descriptionTextField.isUserInteractionEnabled = false
        textFieldView.backgroundColor = .white
    }
    
    func updateData(deadline: Date, descr: String) {
        datePicker.date = deadline
        descriptionTextField.text = descr
        updateDatePicker()
    }
  
    func close() {
        goBack()
    }
}
