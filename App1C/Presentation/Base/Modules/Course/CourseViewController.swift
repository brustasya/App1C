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
        BaseModel(id: 2, title: "Чат курса", image: Images.chat.uiImage)
    ]
    private lazy var timeTableBackgroundView = UIView()
    private lazy var timeTableView = UITableView()
    private lazy var times: [DayTimeModel] = [
        DayTimeModel(day: "Среда,", time: "9:00-10:25"),
        DayTimeModel(day: "Пятница,", time: "10:45-12:10"),
    ]
    
    private lazy var descriptionView = UIView()
    private lazy var descriptionTextField = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupTitle()
        setupLinksView()
        setupTimeTable()
        setupDescription()
    }
    
    private func setupTitle() {
        navigationItem.hidesBackButton = true
        (navigationController as? CustomNavigationController)?.setupBackButton()
        (navigationController as? CustomNavigationController)?.backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
        titleLabel = TitleView(frame: CGRect(x: 30, y: 25, width: view.frame.width, height: 30), title: "Тестирование программного обеспечения")
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -30),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25)
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
    
    private func setupTimeTable() {
        timeTableView.register(DayTimeCell.self, forCellReuseIdentifier: "DayTimeCell")
        timeTableView.delegate = self
        timeTableView.dataSource = self
        
        timeTableBackgroundView = TableView(
            contentView: view,
            frame: view.frame,
            title: "Расписание",
            tableView: timeTableView
        )
        
        timeTableBackgroundView.backgroundColor = .white
        timeTableView.layer.borderColor = UIColor.clear.cgColor
        timeTableView.separatorColor = .clear
        
        view.addSubview(timeTableBackgroundView)
        timeTableBackgroundView.addSubview(timeTableView)
        timeTableBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        timeTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timeTableView.heightAnchor.constraint(equalToConstant: CGFloat(Double(linksModels.count * 30) - 0.5)),
            timeTableBackgroundView.heightAnchor.constraint(equalTo: timeTableView.heightAnchor, constant: 60),
            timeTableBackgroundView.bottomAnchor.constraint(equalTo: timeTableView.bottomAnchor, constant: 15),
            timeTableBackgroundView.topAnchor.constraint(equalTo: linksView.bottomAnchor, constant: -5)
        ])
    }
    
    private func setupDescription() {
        let title = UILabel()
        let textFieldView = UIView()
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
        descriptionTextField.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
        descriptionTextField.textContainer.maximumNumberOfLines = 0
        descriptionTextField.font = .systemFont(ofSize: 15, weight: .regular)
        descriptionTextField.textAlignment = .justified
        
        textFieldView.backgroundColor = .white
        textFieldView.layer.cornerRadius = 15
        
        NSLayoutConstraint.activate([
            descriptionView.topAnchor.constraint(equalTo: timeTableBackgroundView.bottomAnchor, constant: -20),
            descriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descriptionView.heightAnchor.constraint(equalToConstant: 200),
            
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
    
    @objc func goBack() {
        print("go back")
    }
}

extension CourseViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == linksTableView {
            return linksModels.count
        } else {
            return times.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == linksTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "BaseCell", for: indexPath) as? BaseCell else {
                fatalError("Cannot create BaseCell")
            }
            cell.configure(with: linksModels[indexPath.row])
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DayTimeCell", for: indexPath) as? DayTimeCell else {
                fatalError("Cannot create DayTimeCell")
            }
            cell.configure(with: times[indexPath.row])
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     //   output.selectedRowAt(index: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == linksTableView {
            return 50
        } else {
            return 30
        }
    }
}



