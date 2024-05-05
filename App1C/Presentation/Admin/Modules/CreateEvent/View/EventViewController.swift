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
    private lazy var messageLabel = UILabel()
    
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
    
    private var output: EventViewOutput
        
    init(output: EventViewOutput) {
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
        setupDescription()
        setupScrollView()
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
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: 10),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
                
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: 0)
        scrollView.isScrollEnabled = true
    }
    
    private func setupTableView() {
        coursesTableView.register(CourseCell.self, forCellReuseIdentifier: "CourseCell")
        coursesTableView.delegate = self
        coursesTableView.dataSource = self
        
        coursesView = TableView(
            contentView: view,
            frame: view.frame,
            title: "",
            tableView: coursesTableView,
            margin: 0
        )
        
        coursesView.backgroundColor = .white
        coursesTableView.layer.borderColor = UIColor.clear.cgColor
        coursesTableView.separatorColor = UIColor.clear
        
        scrollView.addSubview(coursesView)
        coursesView.addSubview(coursesTableView)
        coursesView.translatesAutoresizingMaskIntoConstraints = false
        coursesTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            coursesTableView.heightAnchor.constraint(equalToConstant: 10000),
            coursesView.heightAnchor.constraint(equalTo: coursesTableView.heightAnchor, constant: 30),
            coursesView.bottomAnchor.constraint(equalTo: coursesTableView.bottomAnchor, constant: 15),
            coursesView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: -10)
        ])
        
        scrollView.contentSize.height = CGFloat(courses.count * 80 + 20)
    }
    
    private func setupMessageLabel() {
        view.addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        messageLabel.numberOfLines = 0
        messageLabel.textColor = .black
        messageLabel.font = .systemFont(ofSize: 17, weight: .regular)
        messageLabel.textAlignment = .justified
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25),
            messageLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -60),
            messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            messageLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -300)
        ])
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
    
    func setupReadMode() {
        datePicker.isUserInteractionEnabled = false
        descriptionTextField.isUserInteractionEnabled = false
        textFieldView.backgroundColor = .white
    }
    
    func addGoOverButton() {
        setupGoOverButton()
    }
    
    func updateData(deadline: Date, descr: String) {
        datePicker.date = deadline
        descriptionTextField.text = descr
        updateDatePicker()
    }
    
    func updateCourses(courses: [CourseModel]) {
        self.courses = courses
        setupTableView()
    }
    
    func setupMessage(text: String) {
        deadlineLabel.isHidden = true
        datePicker.isHidden = true
        descriptionView.isHidden = true
        messageLabel.text = text
        setupMessageLabel()
    }
    
    func close() {
        goBack()
    }
}

extension EventViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CourseCell", for: indexPath) as? CourseCell else {
            fatalError("Cannot create CourseCell")
        }
        cell.configure(with: courses[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.selectCourse(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

