//
//  CoursesListViewController.swift
//  App1C
//
//  Created by Станислава on 19.04.2024.
//

import UIKit

class CoursesListViewController: UIViewController {
    
    private lazy var scrollView = UIScrollView()
    private lazy var addCourseButton = UIButton()
    private lazy var titleLabel = UILabel()
    private lazy var coursesView = UIView()
    private lazy var coursesTableView = UITableView()
    private lazy var courses: [CourseModel] = []
    
    private var output: CoursesListViewOutput

    init(output: CoursesListViewOutput) {
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
        setupScrollView()
        setupTableView()
        output.viewIsReady()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true
        (navigationController as? CustomNavigationController)?.setupBackButton()
        (navigationController as? CustomNavigationController)?.backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
        tabBarController?.tabBar.isTranslucent = true
        tabBarController?.tabBar.isHidden = true
        output.viewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        (navigationController as? CustomNavigationController)?.hideBackButton()
    }
    
    private func setupTitle() {
        titleLabel = TitleView(frame: CGRect(x: 30, y: 25, width: view.frame.width - 60, height: 30), title: "Курсы кафедры")
        view.addSubview(titleLabel)
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
    
    private func setupAddCourseButton() {
        let y = tabBarController?.tabBar.frame.minY ?? view.frame.maxY
        addCourseButton = ButtonView(frame: CGRect(x: 25, y: y - 100, width: view.frame.width - 50, height: 45))
        view.addSubview(addCourseButton)
        addCourseButton.setTitle("Добавить", for: .normal)
        addCourseButton.addTarget(self, action: #selector(addCourse), for: .touchUpInside)
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
                
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: 0)
        scrollView.isScrollEnabled = true
    }
    
    @objc func addCourse() {
        output.addCourseButtonTapped(navigationController: navigationController)
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
}

extension CoursesListViewController: CoursesListViewInput {
    func setupTitle(title: String) {
        titleLabel.text = title
    }
    
    func setupCourses(courses: [CourseModel]) {
        self.courses = courses
        scrollView.contentSize.height = CGFloat(courses.count * 80 + 20)
        coursesTableView.reloadData()
    }
    
    func setupBaseMode() {
        NSLayoutConstraint.activate([
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupAdminMode() {
        setupAddCourseButton()
        
        NSLayoutConstraint.activate([
            scrollView.bottomAnchor.constraint(equalTo: addCourseButton.topAnchor, constant: -10)
        ])
    }
}

extension CoursesListViewController: UITableViewDataSource, UITableViewDelegate {
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
        output.selectCourse(at: indexPath.row, navigationController: navigationController)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}






