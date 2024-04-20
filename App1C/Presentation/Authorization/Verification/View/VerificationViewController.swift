//
//  VerificationViewController.swift
//  App1C
//
//  Created by Станислава on 17.04.2024.
//

import UIKit

class VerificationViewController: UIViewController {
    
    private var output: VerificationViewOutput
    
    private lazy var titleLabel = UILabel()
    private lazy var loginView = UIView()
    private lazy var loginTextField = UITextField()
    private lazy var passwordView = UIView()
    private lazy var passwordTextField = UITextField()
    private lazy var loginButton = UIButton()
    
    init(output: VerificationViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white//Colors.paleYellow.uiColor
        
        setupTitle()
        setupTextFields()
        setupLoginButton()
        setupImage()
        loginTextField.text = "Stanislava.Bobruskina@yandex.ru"
        passwordTextField.text = "8efa741e-d811-44b3-b8ec-75934cf51a94"
       // output.viewIsReady()
    }
    
    private func setupTitle() {
        titleLabel = TitleView(frame: CGRect(x: view.frame.midX - 30, y: 125, width: 60, height: 30), title: "Вход")
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
    }
    
    private func setupTextFields() {
        loginTextField.placeholder = "Email"
        passwordTextField.placeholder = "Пароль"
        
        createTextField(backgroundView: loginView, textField: loginTextField)
        createTextField(backgroundView: passwordView, textField: passwordTextField)
        
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            passwordView.topAnchor.constraint(equalTo: loginView.bottomAnchor, constant: 10)
        ])
    }
    
    private func createTextField(backgroundView: UIView, textField: UITextField) {
        view.addSubview(backgroundView)
        backgroundView.addSubview(textField)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundView.backgroundColor = .systemGray6
        backgroundView.layer.cornerRadius = 20
        
        textField.textColor = .black
        textField.tintColor = .darkGray
        textField.autocapitalizationType = .none
        
        NSLayoutConstraint.activate([
            backgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundView.heightAnchor.constraint(equalToConstant: 50),
            backgroundView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            
            textField.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            textField.widthAnchor.constraint(equalTo: backgroundView.widthAnchor, constant: -30)
        ])
    }
    
    private func setupLoginButton() {
        loginButton = ButtonView(frame: .zero)
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        loginButton.setTitle("Вход", for: .normal)
        
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            loginButton.heightAnchor.constraint(equalToConstant: 45),
            loginButton.topAnchor.constraint(equalTo: passwordView.bottomAnchor, constant: 20)
        ])
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    @objc private func loginButtonTapped() {
        output.loginButtonTapped(
            login: loginTextField.text ?? "",
            password: passwordTextField.text ?? ""
        )
    }
    
    private func setupImage() {
        let imageView = UIImageView(image: Images.biglogo.uiImage)
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 30),
            imageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}

extension VerificationViewController: VerificationViewInput { }
