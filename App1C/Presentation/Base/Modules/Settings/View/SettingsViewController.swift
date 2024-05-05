//
//  SettingsViewController.swift
//  App1C
//
//  Created by Станислава on 02.04.2024.
//

import UIKit

class SettingsViewController: UIViewController {
    
    lazy var baseBackgroundView = UIView()
    lazy var baseTableView = UITableView()
    lazy var baseElements: [BaseModel] = [
        BaseModel(id: 0, title: "Личные данные", image: Images.person.uiImage),
        BaseModel(id: 1, title: "Cписок администраторов", image: Images.persons.uiImage),
        BaseModel(id: 2, title: "Чат кафедры", image: Images.chat.uiImage),
        BaseModel(id: 3, title: "Выход", image: Images.exit.uiImage),
    ]
    
    lazy var educationBackgroundView = UIView()
    lazy var educationTableView = UITableView()
    lazy var education: [BaseModel] = [
        BaseModel(id: 0, title: "Список преподавателей", image: Images.graduationcap.uiImage),
        BaseModel(id: 1, title: "Cписок студентов", image: Images.persons.uiImage),
        BaseModel(id: 2, title: "Архив студентов", image: Images.archive.uiImage),
        BaseModel(id: 3, title: "Список курсов", image: Images.books.uiImage),
    ]
    
    lazy var diplomaBackgroundView = UIView()
    lazy var diplomaTableView = UITableView()
    lazy var diploma: [BaseModel] = [
        BaseModel(id: 0, title: "Темы дипломов", image: Images.book.uiImage),
        BaseModel(id: 1, title: "Результаты НИРов", image: Images.exclamationmark.uiImage),
        BaseModel(id: 2, title: "Оценки за НИРы", image: Images.estimating.uiImage),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        (navigationController as? CustomNavigationController)?.hideBackButton()
        tabBarController?.tabBar.isTranslucent = true
        tabBarController?.tabBar.isHidden = false
    }
    
    func setupBaseElements() {
        baseTableView.register(BaseCell.self, forCellReuseIdentifier: "BaseCell")
        baseTableView.delegate = self
        baseTableView.dataSource = self
        
        baseBackgroundView = TableView(
            contentView: view,
            frame: view.frame,
            title: "",
            tableView: baseTableView
        )
        
        baseBackgroundView.backgroundColor = .systemGray6
        
        view.addSubview(baseBackgroundView)
        baseBackgroundView.addSubview(baseTableView)
        baseBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        baseTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            baseBackgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            baseTableView.heightAnchor.constraint(equalToConstant: CGFloat(baseElements.count * 45) - 0.5),
            baseBackgroundView.heightAnchor.constraint(equalTo: baseTableView.heightAnchor, constant: 30),
            baseBackgroundView.bottomAnchor.constraint(equalTo: baseTableView.bottomAnchor, constant: 15)
        ])
    }
    
    func setupEducationElements() {
        educationTableView.register(BaseCell.self, forCellReuseIdentifier: "BaseCell")
        educationTableView.delegate = self
        educationTableView.dataSource = self
        
        educationBackgroundView = TableView(
            contentView: view,
            frame: view.frame,
            title: "Обучение",
            tableView: educationTableView
        )
        
        educationBackgroundView.backgroundColor = .systemGray6
      
        view.addSubview(educationBackgroundView)
        educationBackgroundView.addSubview(educationTableView)
        educationBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        educationTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            educationBackgroundView.topAnchor.constraint(equalTo: baseBackgroundView.bottomAnchor, constant: -10),
            educationTableView.heightAnchor.constraint(equalToConstant: CGFloat(education.count * 45) - 0.5),
            educationBackgroundView.heightAnchor.constraint(equalTo: educationTableView.heightAnchor, constant: 60),
            educationBackgroundView.bottomAnchor.constraint(equalTo: educationTableView.bottomAnchor, constant: 15)
        ])
    }
    
    func setupDiplomaElements() {
        diplomaTableView.register(BaseCell.self, forCellReuseIdentifier: "BaseCell")
        diplomaTableView.delegate = self
        diplomaTableView.dataSource = self
        
        diplomaBackgroundView = TableView(
            contentView: view,
            frame: view.frame,
            title: "Диплом",
            tableView: diplomaTableView
        )
        
        diplomaBackgroundView.backgroundColor = .systemGray6
      
        view.addSubview(diplomaBackgroundView)
        diplomaBackgroundView.addSubview(diplomaTableView)
        diplomaBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        diplomaTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            diplomaBackgroundView.topAnchor.constraint(equalTo: educationBackgroundView.bottomAnchor, constant: -10),
            diplomaTableView.heightAnchor.constraint(equalToConstant: CGFloat(diploma.count * 45) - 0.5),
            diplomaBackgroundView.heightAnchor.constraint(equalTo: diplomaTableView.heightAnchor, constant: 60),
            diplomaBackgroundView.bottomAnchor.constraint(equalTo: diplomaTableView.bottomAnchor, constant: 15)
        ])
    }
}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == baseTableView {
            return baseElements.count
        } else if tableView == educationTableView {
            return education.count
        } else {
            return diploma.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BaseCell", for: indexPath) as? BaseCell else {
            fatalError("Cannot create BaseCell")
        }
        if tableView == baseTableView {
            cell.configure(with: baseElements[indexPath.row])
        } else if tableView == educationTableView {
            cell.configure(with: education[indexPath.row])
        } else {
            cell.configure(with: diploma[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
}
