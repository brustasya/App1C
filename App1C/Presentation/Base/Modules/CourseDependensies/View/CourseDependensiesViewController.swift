//
//  CourseDependensiesViewController.swift
//  App1C
//
//  Created by Станислава on 08.05.2024.
//

import UIKit

class CourseDependensiesViewController: UIViewController {
    
    private lazy var titleLabel = UILabel()
    private lazy var coursesView = UIView()
    private lazy var coursesTableView = UITableView()
    private lazy var courses: [CourseModel] = []
    private lazy var addButton = UIButton()
    
    private var output: CourseDependensiesViewOutput
    
    init(output: CourseDependensiesViewOutput) {
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
        setupTableView()
        output.viewIsReady()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.viewWillAppear()
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
        titleLabel = TitleView(frame: CGRect(x: 30, y: 25, width: view.frame.width - 60, height: 60), title: "")
        view.addSubview(titleLabel)
    }
    
    private func setupTableView() {
        coursesTableView.register(CourseCell.self, forCellReuseIdentifier: "CourseCell")
        coursesTableView.delegate = self
        coursesTableView.dataSource = self
        
        coursesView = TableView(
            contentView: view,
            frame: view.frame,
            title: "Зависимости",
            tableView: coursesTableView,
            margin: 0
        )
        
        coursesView.backgroundColor = .white
        coursesTableView.layer.borderColor = UIColor.clear.cgColor
        coursesTableView.layer.cornerRadius = 0
        coursesTableView.separatorColor = .clear
        coursesTableView.isScrollEnabled = true
        
        view.addSubview(coursesView)
        coursesView.addSubview(coursesTableView)
        coursesView.translatesAutoresizingMaskIntoConstraints = false
        coursesTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            coursesView.heightAnchor.constraint(equalTo: coursesTableView.heightAnchor, constant: 50),
            coursesView.bottomAnchor.constraint(equalTo: coursesTableView.bottomAnchor, constant: 0),
            coursesView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10)
        ])
    }
    
    private func setupAddButton() {
        let y = tabBarController?.tabBar.frame.minY ?? view.frame.maxY
        addButton = ButtonView(frame: CGRect(x: 25, y: y - 100, width: view.frame.width - 50, height: 45))
        view.addSubview(addButton)
        addButton.setTitle("Добавить зависимости", for: .normal)
        
        addButton.addTarget(self, action: #selector(addStudentButtonTapped), for: .touchUpInside)
    }
    
    @objc private func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func addStudentButtonTapped() {
        output.addButtonTapped(controller: navigationController)
    }
}

extension CourseDependensiesViewController: CourseDependensiesViewInput {
    func updateCoursesTable(with courses: [CourseModel]) {
        self.courses = courses
        coursesTableView.reloadData()
    }
    
    func updateTitle(title: String) {
        titleLabel.text = title
    }
    
    func setupBaseMode() {
        NSLayoutConstraint.activate([
            coursesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupEditMode() {
        setupAddButton()
        NSLayoutConstraint.activate([
            coursesTableView.bottomAnchor.constraint(equalTo: addButton.topAnchor, constant: -10)
        ])
    }
}

extension CourseDependensiesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CourseCell", for: indexPath) as? CourseCell else {
            fatalError("Cannot create CourseCell")
        }
        cell.configure(with: courses[indexPath.row])
        cell.hideButton()
        cell.selectionStyle = .none
        return cell
    }
}

