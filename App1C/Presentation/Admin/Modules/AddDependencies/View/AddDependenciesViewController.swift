//
//  AddDependenciesViewController.swift
//  App1C
//
//  Created by Станислава on 19.04.2024.
//

import UIKit

class AddDependenciesViewController: UIViewController {
    
    private lazy var scrollView = UIScrollView()
    private lazy var finishEstimatingButton = UIButton()
    private lazy var titleLabel = UILabel()
    private lazy var coursesView = UIView()
    private lazy var coursesTableView = UITableView()
    private lazy var courses: [AddDependenceModel] = [
        AddDependenceModel(id: 0, title: "Программирование", isCourseDependency: true),
        AddDependenceModel(id: 0, title: "Тестирование", isCourseDependency: false),
        AddDependenceModel(id: 0, title: "Математический анализ", isCourseDependency: true),
        AddDependenceModel(id: 0, title: "Линейная алгебра", isCourseDependency: false),
        AddDependenceModel(id: 0, title: "Аналитическая геометрия", isCourseDependency: false),
    ]
    
    private var output: AddDependenciesViewOutput

    init(output: AddDependenciesViewOutput) {
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
        setupFinishEstimatingButton()
        setupScrollView()
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
        titleLabel = TitleView(frame: CGRect(x: 30, y: 25, width: view.frame.width - 60, height: 30), title: "Добавить зависимости")
        view.addSubview(titleLabel)
    }
    
    private func setupTableView() {
        coursesTableView.register(AddDependenceCell.self, forCellReuseIdentifier: "AddDependenceCell")
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
            coursesTableView.heightAnchor.constraint(equalToConstant: CGFloat(Double(courses.count * 80))),
            coursesView.heightAnchor.constraint(equalTo: coursesTableView.heightAnchor, constant: 30),
            coursesView.bottomAnchor.constraint(equalTo: coursesTableView.bottomAnchor, constant: 15),
            coursesView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: -10)
        ])
        
        scrollView.contentSize.height = CGFloat(courses.count * 80 - 80)
    }
    
    private func setupFinishEstimatingButton() {
        let y = tabBarController?.tabBar.frame.minY ?? view.frame.maxY
        finishEstimatingButton = ButtonView(frame: CGRect(x: 25, y: y - 100, width: view.frame.width - 50, height: 45))
        view.addSubview(finishEstimatingButton)
        finishEstimatingButton.setTitle("Добавить", for: .normal)
        finishEstimatingButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: finishEstimatingButton.topAnchor, constant: -20)
        ])
                
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: 0)
        scrollView.isScrollEnabled = true
    }
    
    @objc private func addButtonTapped() {
        output.addButtonTapped()
    }
    
    @objc private func goBack() {
        navigationController?.popViewController(animated: true)
    }
}

//extension EstimationViewController: PersonListViewInput {
//    func setupPersonTable(with persons: [BaseModel]) {
//        self.persons = persons
//        setupTableView()
//    }
//
//    func updateTitle(title: String) {
//        titleLabel.text = title
//    }
//}

extension AddDependenciesViewController: AddDependenciesViewInput {
    func updateCourses(with courses: [AddDependenceModel]) {
        self.courses = courses
        setupTableView()
    }
    
    func close() {
        goBack()
    }
}

extension AddDependenciesViewController: SelectItemDelegate {
    func select(id: Int) {
        output.addCourse(id: id)
    }
    
    func unSelect(id: Int) {
        output.removeCourse(id: id)
    }
}

extension AddDependenciesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AddDependenceCell", for: indexPath) as? AddDependenceCell else {
            fatalError("Cannot create AddDependenceCell")
        }
        cell.configure(with: courses[indexPath.row])
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

protocol SelectItemDelegate: AnyObject {
    func select(id: Int)
    func unSelect(id: Int)
}
