//
//  StudentsListViewController.swift
//  App1C
//
//  Created by Станислава on 18.04.2024.
//

import UIKit

final class StudentsListViewController: UIViewController {
    
    private lazy var titleLabel = UILabel()
    private lazy var addStudentButton = UIButton()
    private lazy var courseSelector = UIView()
    private lazy var studentsView = UIView()
    private lazy var studentsTableView = UITableView()
    private lazy var students: [BaseModel] = []
    
    private var output: StudentsListViewOutput

    init(output: StudentsListViewOutput) {
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
        setupAddStudentButton()
        setupTableView()
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
        titleLabel = TitleView(frame: CGRect(x: 30, y: 25, width: view.frame.width, height: 30), title: "Студенты")
        view.addSubview(titleLabel)

        let daysOfWeek = ["3", "4", "5", "6"]
        courseSelector = SelectorView(
            frame: CGRect(x: view.frame.midX - 140, y: 70, width: 300, height: 50),
            buttonsTitles: daysOfWeek,
            delegate: self
        )
        view.addSubview(courseSelector)
    }
    
    private func setupTableView() {
        studentsTableView.register(BaseCell.self, forCellReuseIdentifier: "BaseCell")
        studentsTableView.delegate = self
        studentsTableView.dataSource = self
        
        studentsView = TableView(
            contentView: view,
            frame: view.frame,
            title: "",
            tableView: studentsTableView,
            margin: 0
        )
        
        studentsView.backgroundColor = .white
        studentsTableView.layer.borderColor = UIColor.clear.cgColor
        studentsTableView.layer.cornerRadius = 0
        studentsTableView.isScrollEnabled = true
        
        view.addSubview(studentsView)
        studentsView.addSubview(studentsTableView)
        studentsView.translatesAutoresizingMaskIntoConstraints = false
        studentsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            studentsTableView.bottomAnchor.constraint(equalTo: addStudentButton.topAnchor, constant: -20),
            studentsView.heightAnchor.constraint(equalTo: studentsTableView.heightAnchor, constant: 30),
            studentsView.bottomAnchor.constraint(equalTo: studentsTableView.bottomAnchor, constant: 15),
            studentsView.topAnchor.constraint(equalTo: courseSelector.bottomAnchor, constant: 0)
        ])
    }
    
    private func setupAddStudentButton() {
        let y = tabBarController?.tabBar.frame.minY ?? view.frame.maxY
        addStudentButton = ButtonView(frame: CGRect(x: 25, y: y - 100, width: view.frame.width - 50, height: 45))
        view.addSubview(addStudentButton)
        addStudentButton.setTitle("Добавить студента", for: .normal)
        
        addStudentButton.addTarget(self, action: #selector(addStudent), for: .touchUpInside)
    }
    
    @objc func addStudent() {
        output.addStudent()
    }
    
    @objc func goBack() {
        output.goBack()
    }
}

extension StudentsListViewController: StudentsListViewInput {
    func setupStudents(students: [BaseModel]) {
        self.students = students
        studentsTableView.reloadData()
    }
}

extension StudentsListViewController: SelectorDelegate {
    func select(at index: Int, sender: SelectorView) {
        output.selectCourse(at: index)
    }
}

extension StudentsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BaseCell", for: indexPath) as? BaseCell else {
            fatalError("Cannot create BaseCell")
        }
        cell.configure(with: students[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.selectStudent(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
