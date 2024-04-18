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
}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == baseTableView {
            return baseElements.count
        } else {
            return education.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BaseCell", for: indexPath) as? BaseCell else {
            fatalError("Cannot create BaseCell")
        }
        if tableView == baseTableView {
            cell.configure(with: baseElements[indexPath.row])
        } else {
            cell.configure(with: education[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
}
