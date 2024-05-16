//
//  TeacherCoursesListViewController.swift
//  App1C
//
//  Created by Станислава on 02.04.2024.
//

import UIKit

class TeacherCoursesListViewController: UIViewController {
    
    private lazy var scrollView = UIScrollView()
    
    private lazy var currentCoursesBackgroundView = UIView()
    private lazy var currentCoursesTableView = UITableView()
    private lazy var currentCoursesButton = UIButton(type: .system)
    private lazy var currentCoursesState: ListState = .open
    private var currentCourseConstraint: NSLayoutConstraint?
    private lazy var currentCourses: [CourseModel] = [
//        CourseModel(id: 0, title: "Тестирование программного обеспечения", isTeacherCourse: true, isCourseDependency: false),
//        CourseModel(id: 0, title: "Программирование", isTeacherCourse: true, isCourseDependency: false),
//        CourseModel(id: 0, title: "Разработка программного обеспечения. Java", isTeacherCourse: true, isCourseDependency: false)
    ]
    
    private var output: TeacherCoursesListViewOutput
        
    init(output: TeacherCoursesListViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(scrollView)
        setupScrollView()
        setupCurrentCourses()
        output.viewIsReady()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isTranslucent = true
        tabBarController?.tabBar.isHidden = false
        output.viewIsReady()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupScrollView()
    }
    
    private func setupScrollView() {
        scrollView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        scrollView.isScrollEnabled = true
    }
    
    private func setupCurrentCourses() {
        currentCoursesTableView.register(CourseCell.self, forCellReuseIdentifier: "CourseCell")
        currentCoursesTableView.delegate = self
        currentCoursesTableView.dataSource = self
        
        currentCoursesBackgroundView = TableView(
            contentView: scrollView,
            frame: scrollView.frame,
            title: "Мои курсы",
            tableView: currentCoursesTableView,
          //  button: currentCoursesButton,
            largeTitle: true
        )
        
        currentCoursesTableView.layer.borderColor = UIColor.clear.cgColor
        currentCoursesTableView.separatorColor = .clear
        currentCoursesBackgroundView.backgroundColor = .white
      
        scrollView.addSubview(currentCoursesBackgroundView)
        currentCoursesBackgroundView.addSubview(currentCoursesTableView)
        currentCoursesBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        currentCoursesTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            currentCoursesBackgroundView.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 20),
            //currentCoursesTableView.heightAnchor.constraint(equalToConstant: CGFloat(currentCourses.count * 60) - 0.5),
            currentCoursesBackgroundView.heightAnchor.constraint(equalTo: currentCoursesTableView.heightAnchor, constant: 70),
            currentCoursesBackgroundView.bottomAnchor.constraint(equalTo: currentCoursesTableView.bottomAnchor, constant: 15)
        ])
        
//        currentCourseConstraint = currentCoursesTableView.heightAnchor.constraint(equalToConstant: CGFloat(currentCourses.count * 80) - 0.5)
//        currentCourseConstraint?.isActive = true
        currentCoursesButton.addTarget(self, action: #selector(currentCoursesButtonTapped), for: .touchUpInside)
    }
    
    @objc private func currentCoursesButtonTapped() {
        switch currentCoursesState {
        case .open:
            currentCoursesButton.setImage(Images.down.uiImage, for: .normal)
            currentCourseConstraint?.isActive = false
            currentCoursesState = .close
            return
        case .close:
            currentCoursesButton.setImage(Images.up.uiImage, for: .normal)
            currentCourseConstraint?.isActive = true
            currentCoursesState = .open
            return
        }
    }
}

extension TeacherCoursesListViewController: TeacherCoursesListViewInput {
    func setupCourses(courses: [CourseModel]) {
        currentCourses = courses
        currentCourseConstraint = currentCoursesTableView.heightAnchor.constraint(equalToConstant: CGFloat(currentCourses.count * 80) - 0.5)
        currentCourseConstraint?.isActive = true
        currentCoursesTableView.reloadData()
        let height = CGFloat(currentCourses.count * 60 + 200)
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: height)
    }
}

extension TeacherCoursesListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return currentCourses.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.selectCourse(index: indexPath.row, controller: navigationController)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CourseCell", for: indexPath) as? CourseCell else {
            fatalError("Cannot create CurrentCourseCell")
        }
        cell.configure(with: currentCourses[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
}
