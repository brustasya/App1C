//
//  AddPersonViewController.swift
//  App1C
//
//  Created by Станислава on 18.04.2024.
//

import UIKit

class AddPersonViewController: UIViewController {
    private lazy var titleLabel = UILabel()
    
    private lazy var surnameView = UIView()
    private lazy var surnameTextField = UITextField()
    
    private lazy var nameView = UIView()
    private lazy var nameTextField = UITextField()
    
    private lazy var patronymicView = UIView()
    private lazy var patronymicTextField = UITextField()
    
    let emailTitle = UILabel()
    private lazy var emailView = UIView()
    private lazy var emailTextField = UITextField()
   
    let semesterTitle = UILabel()
    private lazy var semesterView = UIView()
    private lazy var semesterTextField = UITextField()
    
    private var output: AddPersonViewOutput

    init(output: AddPersonViewOutput) {
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
        setupSemester()
        setupEmail()
        setupAddButton()
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
        titleLabel = TitleView(frame: CGRect(x: 30, y: 25, width: view.frame.width, height: 30), title: "")
        view.addSubview(titleLabel)
    }
    
    private func setupSurname() {
        let surnameTitle = UILabel()
        createTextField(title: surnameTitle, textField: surnameTextField, backgroundView: surnameView)
        surnameTitle.text = "Фамилия"
        surnameTextField.placeholder = "Введите фамилию"
        
        let nameTitle = UILabel()
        createTextField(title: nameTitle, textField: nameTextField, backgroundView: nameView)
        nameTitle.text = "Имя"
        nameTextField.placeholder = "Введите имя"
        
        let patronymicTitle = UILabel()
        createTextField(title: patronymicTitle, textField: patronymicTextField, backgroundView: patronymicView)
        patronymicTitle.text = "Отчество"
        patronymicTextField.placeholder = "Введите отчество"
        
        NSLayoutConstraint.activate([
            surnameView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            nameView.topAnchor.constraint(equalTo: surnameView.bottomAnchor, constant: 10),
            patronymicView.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 10)
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
            semesterView.topAnchor.constraint(equalTo: patronymicView.bottomAnchor, constant: 20),
            semesterTitle.centerYAnchor.constraint(equalTo: semesterView.centerYAnchor),
            semesterTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            semesterView.leadingAnchor.constraint(equalTo: semesterTitle.trailingAnchor, constant: 20),
            semesterView.heightAnchor.constraint(equalToConstant: 40),
            semesterView.widthAnchor.constraint(equalToConstant: 60),
            
            semesterTextField.heightAnchor.constraint(equalToConstant: 40),
            semesterTextField.widthAnchor.constraint(equalToConstant: 40),
            semesterTextField.centerXAnchor.constraint(equalTo: semesterView.centerXAnchor),
            semesterTextField.centerYAnchor.constraint(equalTo: semesterView.centerYAnchor),
        ])
    }
    
    private func setupEmail() {
        createTitle(title: emailTitle)
        emailTitle.text = "Логин (почта):"
        emailTextField.placeholder = "Email"
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no
        surnameTextField.autocorrectionType = .no
        
        view.addSubview(emailView)
        emailView.addSubview(emailTextField)
        emailView.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailView.layer.cornerRadius = 15
        emailView.backgroundColor = .systemGray6

        emailTextField.backgroundColor = .systemGray6
        emailTextField.textColor = .black
        emailTextField.tintColor = .gray
        
       
        NSLayoutConstraint.activate([
            emailView.topAnchor.constraint(equalTo: emailTitle.bottomAnchor, constant: 15),
            
            emailView.heightAnchor.constraint(equalToConstant: 40),
            emailView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            emailView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            emailTextField.leadingAnchor.constraint(equalTo: emailView.leadingAnchor, constant: 15),
            emailTextField.trailingAnchor.constraint(equalTo: emailView.trailingAnchor, constant: -15),
            emailTextField.centerXAnchor.constraint(equalTo: emailView.centerXAnchor),
            emailTextField.centerYAnchor.constraint(equalTo: emailView.centerYAnchor),
        ])
    }
    
    private func setupAddButton() {
        let y = tabBarController?.tabBar.frame.minY ?? view.frame.maxY
        let addStudentButton = ButtonView(frame: CGRect(x: 25, y: y - 100, width: view.frame.width - 50, height: 45))
        view.addSubview(addStudentButton)
        addStudentButton.setTitle("Добавить", for: .normal)
        
        addStudentButton.addTarget(self, action: #selector(addStudent), for: .touchUpInside)
    }
    
    @objc func addStudent() {
        output.addButtonTapped(
            secondName: surnameTextField.text ?? "",
            firstName: nameTextField.text ?? "",
            surname: patronymicTextField.text ?? "",
            email: emailTextField.text ?? "",
            semester: Int(semesterTextField.text ?? "5") ?? 5
        )
    }
    
    @objc func goBack() {
        output.goBack()
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
}

extension AddPersonViewController: AddPersonViewInput {
    func setupTitle(title: String) {
        titleLabel.text = title
    }
    
    func setupStudentsFields() {
        semesterTitle.isHidden = false
        semesterView.isHidden = false
        semesterTextField.isHidden = false
        
        NSLayoutConstraint.activate([
            emailTitle.topAnchor.constraint(equalTo: semesterView.bottomAnchor, constant: 20),
        ])
        
    }
    
    func setupEmailField() {
        semesterTitle.isHidden = true
        semesterView.isHidden = true
        semesterTextField.isHidden = true
        
        NSLayoutConstraint.activate([
            emailTitle.topAnchor.constraint(equalTo: patronymicView.bottomAnchor, constant: 20),
        ])
    }
    
}
