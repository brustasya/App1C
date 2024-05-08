//
//  StudentDiplomaViewController.swift
//  App1C
//
//  Created by Станислава on 07.05.2024.
//

import UIKit

class StudentDiplomaViewController: UIViewController {
    private lazy var titleLabel = UILabel()
    private lazy var degreeSelector = UIView()
    
    private lazy var nameView = UIView()
    private lazy var nameTextField = UITextField()
    
    private lazy var themeTitle = UILabel()
    private lazy var themeView = UIView()
    private lazy var themeTextField = UITextField()
    private lazy var themeLabel = UILabel()
    
    private lazy var gradeTitle = UILabel()
    
    private lazy var telegramView = UIView()
    private lazy var telegramTextField = UITextField()
    
    private lazy var workView = UIView()
    private lazy var workTextField = UITextField()
    
    private lazy var postView = UIView()
    private lazy var postTextField = UITextField()
    
    private lazy var editButton = UIButton()
    
    private lazy var speeches: [SpeechModel] = []
    private lazy var speechesTableView = UITableView()
    private lazy var speechesBackgroundView = UIView()
    private var tableHeightConstraint: NSLayoutConstraint?

    
    private var output: StudentDiplomaViewOutput

    init(output: StudentDiplomaViewOutput) {
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
        setupGrade()
        setupTeacher()
        setupSpeechesTableView()
        output.viewIsReady()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.viewWillAppear()
        (navigationController as? CustomNavigationController)?.hideBackButton()
        tabBarController?.tabBar.isTranslucent = true
        tabBarController?.tabBar.isHidden = false
        (navigationController as? CustomNavigationController)?.bellButton.isHidden = false
    }
    
    private func setupTitle() {
        let degrees = ["Бакалавриат", "Магистратура"]
        degreeSelector = SelectorView(
            frame: CGRect(x: view.frame.midX - 160, y: 25, width: 320, height: 40),
            buttonsTitles: degrees,
            delegate: self,
            width: 150,
            color: Colors.paleYellow.uiColor,
            borderColor: Colors.darkYellow.uiColor
        )
        view.addSubview(degreeSelector)
    }
    
    private func setupTheme() {
        themeTitle.text = "Тема"
        createTitle(title: themeTitle)
        createLargeTextField(textField: themeTextField, backgroundView: themeView)
        view.addSubview(themeLabel)
        themeLabel.translatesAutoresizingMaskIntoConstraints = false

        themeTextField.placeholder = "Не указана"
        themeLabel.textColor = .black
        themeLabel.font = .systemFont(ofSize: 17)
        themeLabel.text = "Не указана"
        themeLabel.numberOfLines = 0
        themeLabel.isHidden = true
        
        NSLayoutConstraint.activate([
            themeTitle.topAnchor.constraint(equalTo: degreeSelector.bottomAnchor, constant: 25),
            themeView.topAnchor.constraint(equalTo: themeTitle.bottomAnchor, constant: 5),
            themeLabel.leadingAnchor.constraint(equalTo: themeTextField.leadingAnchor),
            themeLabel.topAnchor.constraint(equalTo: themeTextField.topAnchor),
            themeLabel.trailingAnchor.constraint(lessThanOrEqualTo: themeView.trailingAnchor)
        ])
    }
    
    private func setupGrade() {
        gradeTitle.text = "Оценка:"
        createTitle(title: gradeTitle)
        gradeTitle.font = .systemFont(ofSize: 17, weight: .medium)
        
        NSLayoutConstraint.activate([
            gradeTitle.topAnchor.constraint(equalTo: themeLabel.bottomAnchor, constant: 30)
        ])
    }
    
    private func setupGrade(gradeModel: GradeModel) {
        let gradeView = GradeView(model: gradeModel, contentView: view, frame: view.frame)
        view.addSubview(gradeView)
        gradeView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gradeView.leadingAnchor.constraint(equalTo: gradeTitle.trailingAnchor, constant: 20),
            gradeView.centerYAnchor.constraint(equalTo: gradeTitle.centerYAnchor),
            gradeView.widthAnchor.constraint(equalToConstant: 100),
            gradeView.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    private func setupTeacher() {
        let teacherTitle = UILabel()
        teacherTitle.text = "Научный руководитель"
        createTitle(title: teacherTitle)
        
        nameTextField.placeholder = "Не указан"
        createLargeTextField(textField: nameTextField, backgroundView: nameView)
        
        let contactsTitle = UILabel()
        contactsTitle.text = "Контакты:"
        createTextField(title: contactsTitle, textField: telegramTextField, backgroundView: telegramView)
        telegramTextField.placeholder = "Не указаны"
        
        let workTitle = UILabel()
        createTextField(title: workTitle, textField: workTextField, backgroundView: workView)
        workTitle.text = "Место работы:"
        workTextField.placeholder = "Не указано"
        
        let postTitle = UILabel()
        createTextField(title: postTitle, textField: postTextField, backgroundView: postView)
        postTitle.text = "Должность:"
        postTextField.placeholder = "Не указана"
        
        NSLayoutConstraint.activate([
            teacherTitle.topAnchor.constraint(equalTo: gradeTitle.bottomAnchor, constant: 30),
            nameView.topAnchor.constraint(equalTo: teacherTitle.bottomAnchor, constant: 5),
            contactsTitle.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 10),
            workTitle.topAnchor.constraint(equalTo: contactsTitle.bottomAnchor, constant: 20),
            postTitle.topAnchor.constraint(equalTo: workTitle.bottomAnchor, constant: 20),
        ])
    }
    
    func setupSpeechesTableView() {
        speechesTableView.register(SpeechCell.self, forCellReuseIdentifier: "SpeechCell")
        speechesTableView.delegate = self
        speechesTableView.dataSource = self
        
        speechesBackgroundView = TableView(
            contentView: view,
            frame: view.frame,
            title: "НИР",
            tableView: speechesTableView
        )
        
        view.addSubview(speechesBackgroundView)
        speechesBackgroundView.addSubview(speechesTableView)
        speechesBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        speechesTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
          //  eventsTableView.heightAnchor.constraint(equalToConstant: CGFloat(Double(events.count * 70) - 0.5)),
            speechesBackgroundView.heightAnchor.constraint(equalTo: speechesTableView.heightAnchor, constant: 60),
            speechesBackgroundView.bottomAnchor.constraint(equalTo: speechesTableView.bottomAnchor, constant: 15),
            speechesBackgroundView.topAnchor.constraint(equalTo: postView.bottomAnchor, constant: 10)
        ])
        
        tableHeightConstraint = speechesTableView.heightAnchor.constraint(equalToConstant: 0)
        tableHeightConstraint?.isActive = true
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
        backgroundView.backgroundColor = .white

        textField.backgroundColor = .white
        textField.textColor = .black
        textField.tintColor = .gray
        textField.isUserInteractionEnabled = false
        
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
        backTextFieldView.backgroundColor = .white

        textField.backgroundColor = .white
        textField.textColor = .black
        textField.tintColor = .gray
        textField.isUserInteractionEnabled = false
        
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
}

extension StudentDiplomaViewController: SelectorDelegate {
    func select(at index: Int, sender: SelectorView) {
        output.selectDegree(bachelor: index == 0)
    }
}

extension StudentDiplomaViewController: StudentDiplomaViewInput {
    func setupSpeeches(speeches: [SpeechModel]) {
        self.speeches = speeches
        speechesTableView.reloadData()
        
        tableHeightConstraint?.isActive = false
        tableHeightConstraint = speechesTableView.heightAnchor.constraint(equalToConstant: CGFloat(speeches.count * 40))
        tableHeightConstraint?.isActive = true
    }
    
    func updateData(model: DiplomaModel) {
        themeTextField.text = model.theme
        nameTextField.text = model.name
        telegramTextField.text = model.contacts
        workTextField.text = model.work
        postTextField.text = model.post
        setupGrade(gradeModel: GradeModel(grade: model.grade))
        
        if model.theme != "" {
            switch model.themeType {
            case ThemeType.department.title:
                themeTitle.text = "Тема (от кафедры)"
            case ThemeType.work.title:
                themeTitle.text = "Тема (от работы)"
            case ThemeType.own.title:
                themeTitle.text = "Тема (своя)"
            default:
                themeTitle.text = "Тема"
            }
            themeLabel.text = model.theme
            themeLabel.isHidden = false
            themeTextField.isHidden = true
        } else {
            themeLabel.text = "Не указана"
            themeLabel.isHidden = true
            themeTextField.isHidden = false
        }
    }
}

extension StudentDiplomaViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return speeches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SpeechCell", for: indexPath) as? SpeechCell else {
            fatalError("Cannot create SpeechCell")
        }
        cell.configure(with: speeches[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}


