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
    
    private lazy var emailView = UIView()
    private lazy var emailTextField = UITextField()
    
    private lazy var telegramView = UIView()
    private lazy var telegramTextField = UITextField()
    
    private lazy var workView = UIView()
    private lazy var workTextField = UITextField()
    
    private lazy var postView = UIView()
    private lazy var postTextField = UITextField()
    
    private lazy var statusLabel = UILabel()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        setupTitle()
        setupSurname()
        setupContacts()
        setupStatus()
        setupWork()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isTranslucent = true
        tabBarController?.tabBar.isHidden = true
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
        
        let emailTitle = UILabel()
        createTextField(title: emailTitle, textField: emailTextField, backgroundView: emailView, secondTitle: true)
        emailTitle.text = "Email"
        emailTextField.placeholder = "Не указан"
        
        let telegramTitle = UILabel()
        createTextField(title: telegramTitle, textField: telegramTextField, backgroundView: telegramView, secondTitle: true)
        telegramTitle.text = "Telegram"
        telegramTextField.placeholder = "Не указан"
        
        NSLayoutConstraint.activate([
            contactsTitle.topAnchor.constraint(equalTo: patronymicView.bottomAnchor, constant: 20),
            emailView.topAnchor.constraint(equalTo: contactsTitle.bottomAnchor, constant: 10),
            telegramView.topAnchor.constraint(equalTo: emailView.bottomAnchor, constant: 10)
        ])
    }
    
    private func setupStatus() {
        let statusTitle = UILabel()
        createTitle(title: statusTitle)
        statusTitle.text = "Статус:"
        
        let backgroundView = UIView()
        view.addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = Colors.paleYellow.uiColor
        backgroundView.layer.cornerRadius = 12.5
        
        backgroundView.addSubview(statusLabel)
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.textColor = .black
        statusLabel.font = .systemFont(ofSize: 16, weight: .regular)
        statusLabel.text = "Учится"
        
        NSLayoutConstraint.activate([
            statusTitle.topAnchor.constraint(equalTo: telegramView.bottomAnchor, constant: 20),
            
            backgroundView.widthAnchor.constraint(equalToConstant: 120),
            backgroundView.heightAnchor.constraint(equalToConstant: 25),
            backgroundView.centerYAnchor.constraint(equalTo: statusTitle.centerYAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: statusTitle.trailingAnchor, constant: 50),
            
            statusLabel.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            statusLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor)
        ])
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
            
            workView.heightAnchor.constraint(equalToConstant: 34),
            workView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            workView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            workTextField.heightAnchor.constraint(equalToConstant: 34),
            workTextField.leadingAnchor.constraint(equalTo: workView.leadingAnchor, constant: 15),
            workTextField.trailingAnchor.constraint(equalTo: workView.trailingAnchor, constant: -15),
            workTextField.centerXAnchor.constraint(equalTo: workView.centerXAnchor),
            workTextField.centerYAnchor.constraint(equalTo: workView.centerYAnchor),
        ])
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
            backgroundView.heightAnchor.constraint(equalToConstant: 34),
            
            title.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: CGFloat(titleMargin)),
            title.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            
            backTextFieldView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -10),
            backTextFieldView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            backTextFieldView.heightAnchor.constraint(equalToConstant: 34),
            backTextFieldView.widthAnchor.constraint(equalToConstant: 220),
            
            textField.heightAnchor.constraint(equalToConstant: 34),
            textField.widthAnchor.constraint(equalToConstant: 190),
            textField.centerXAnchor.constraint(equalTo: backTextFieldView.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: backTextFieldView.centerYAnchor),
        ])
    }
}
