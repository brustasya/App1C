//
//  CoursePersonListViewController.swift
//  App1C
//
//  Created by Станислава on 08.05.2024.
//

import UIKit

class CoursePersonListViewController: UIViewController {
    
    private lazy var titleLabel = UILabel()
    private lazy var personsView = UIView()
    private lazy var personTableView = UITableView()
    private lazy var persons: [BaseModel] = []
    private lazy var addButton = UIButton()
    
    private var output: CoursePersonListViewOutput
    
    init(output: CoursePersonListViewOutput) {
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
    
    private func setupTableView(title: String) {
        personTableView.register(BaseCell.self, forCellReuseIdentifier: "BaseCell")
        personTableView.delegate = self
        personTableView.dataSource = self
        
        personsView = TableView(
            contentView: view,
            frame: view.frame,
            title: title,
            tableView: personTableView,
            margin: 0
        )
        
        personsView.backgroundColor = .white
        personTableView.layer.borderColor = UIColor.clear.cgColor
        personTableView.layer.cornerRadius = 0
        personTableView.isScrollEnabled = true
        
        view.addSubview(personsView)
        personsView.addSubview(personTableView)
        personsView.translatesAutoresizingMaskIntoConstraints = false
        personTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            personTableView.heightAnchor.constraint(equalToConstant: CGFloat(Double(persons.count * 50) - 0.5)),
            personsView.heightAnchor.constraint(equalTo: personTableView.heightAnchor, constant: 60),
            personsView.bottomAnchor.constraint(equalTo: personTableView.bottomAnchor, constant: 15),
            personsView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10)
        ])
    }
    
    @objc private func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func addStudentButtonTapped() {
        output.addButtonTapped(controller: navigationController)
    }
}

extension CoursePersonListViewController: CoursePersonListViewInput {
    func setupPersonTable(with persons: [BaseModel], title: String) {
        self.persons = persons
        setupTableView(title: title)
    }
    
    func updateTitle(title: String) {
        titleLabel.text = title
    }
    
    func setupAddButton(title: String) {
        let y = tabBarController?.tabBar.frame.minY ?? view.frame.maxY
        addButton = ButtonView(frame: CGRect(x: 25, y: y - 100, width: view.frame.width - 50, height: 45))
        view.addSubview(addButton)
        addButton.setTitle(title, for: .normal)
        
        addButton.addTarget(self, action: #selector(addStudentButtonTapped), for: .touchUpInside)
    }
}

extension CoursePersonListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BaseCell", for: indexPath) as? BaseCell else {
            fatalError("Cannot create BaseCell")
        }
        cell.configure(with: persons[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.selectedRowAt(index: indexPath.row, controller: navigationController)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
