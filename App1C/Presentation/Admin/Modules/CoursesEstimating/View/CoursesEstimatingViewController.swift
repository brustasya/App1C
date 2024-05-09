//
//  CoursesEstimatingViewController.swift
//  App1C
//
//  Created by Станислава on 09.05.2024.
//

import UIKit

final class CoursesEstimatingViewController: UIViewController {
    
    private lazy var subTitleLabel = UILabel()
    private lazy var addCoursesButton = UIButton()
    private lazy var coursesSelector = UIView()
    private lazy var speechSelector = UIView()
    private lazy var coursesView = UIView()
    private lazy var coursesTableView = UITableView()
    private lazy var courses: [StudentCourseModel] = []
    private lazy var lastCourses: [StudentCourseModel] = []
    private lazy var currentCourses: [StudentCourseModel] = []
    private lazy var unusedCourses: [StudentCourseModel] = []
    
    private var page = 1
    
    private var output: CoursesEstimatingViewOutput

    init(output: CoursesEstimatingViewOutput) {
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
        setupAddCoursesButton()
        setupPageControl()
        setupTableView()
        output.viewIsReady()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.viewIsReady()
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
        let titleLabel = TitleView(frame: CGRect(x: 30, y: 25, width: view.frame.width, height: 30), title: "Оценки")
        view.addSubview(titleLabel)
        subTitleLabel = TitleView(frame: CGRect(x: 30, y: titleLabel.frame.maxY + 10, width: view.frame.width, height: 30), title: "")
        subTitleLabel.font = .systemFont(ofSize: 18, weight: .medium)
        view.addSubview(subTitleLabel)
    }
    
    private func setupTableView() {
        coursesTableView.register(CourseEstimationCell.self, forCellReuseIdentifier: "CourseEstimationCell")
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
        coursesTableView.layer.cornerRadius = 0
        coursesTableView.isScrollEnabled = true
        
        view.addSubview(coursesView)
        coursesView.addSubview(coursesTableView)
        coursesView.translatesAutoresizingMaskIntoConstraints = false
        coursesTableView.translatesAutoresizingMaskIntoConstraints = false
        coursesTableView.separatorColor = .clear
        
        NSLayoutConstraint.activate([
            coursesTableView.bottomAnchor.constraint(equalTo: coursesSelector.topAnchor, constant: -10),
            coursesView.heightAnchor.constraint(equalTo: coursesTableView.heightAnchor, constant: 15),
            coursesView.bottomAnchor.constraint(equalTo: coursesTableView.bottomAnchor, constant: 0),
            coursesView.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 0)
        ])
    }
    
    private func setupAddCoursesButton() {
        let y = tabBarController?.tabBar.frame.minY ?? view.frame.maxY
        addCoursesButton = ButtonView(frame: CGRect(x: 25, y: y - 100, width: view.frame.width - 50, height: 45))
        view.addSubview(addCoursesButton)
        addCoursesButton.setTitle("Добавить курсы", for: .normal)
        addCoursesButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    private func setupPageControl() {
        let pages = ["1", "2", "3"]
        coursesSelector = SelectorView(
            frame: CGRect(x: view.frame.midX - 75, y: addCoursesButton.frame.minY - 70, width: 150, height: 50),
            buttonsTitles: pages,
            delegate: self
        )
        view.addSubview(coursesSelector)
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func addButtonTapped() {
        output.addButtonTapped(controller: navigationController)
    }
    
    private func showTypesAlert(cell: CourseEstimationCell) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        addAlertAction(title: "отл(10)", alert: alertController, cell: cell, grade: 10)
        addAlertAction(title: "отл(9)", alert: alertController, cell: cell, grade: 9)
        addAlertAction(title: "отл(8)", alert: alertController, cell: cell, grade: 8)
        addAlertAction(title: "хор(7)", alert: alertController, cell: cell, grade: 7)
        addAlertAction(title: "хор(6)", alert: alertController, cell: cell, grade: 6)
        addAlertAction(title: "хор(5)", alert: alertController, cell: cell, grade: 5)
        addAlertAction(title: "удовл(4)", alert: alertController, cell: cell, grade: 4)
        addAlertAction(title: "удовл(3)", alert: alertController, cell: cell, grade: 3)
        addAlertAction(title: "неуд(2)", alert: alertController, cell: cell, grade: 2)
        addAlertAction(title: "неуд(1)", alert: alertController, cell: cell, grade: 1)
       
        alertController.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        alertController.view.backgroundColor = Colors.yellow.uiColor
        alertController.view.tintColor = .black
        alertController.view.layer.cornerRadius = 15

        present(alertController, animated: true)
    }
    
    private func addAlertAction(title: String, alert: UIAlertController, cell: CourseEstimationCell, grade: Int) {
        alert.addAction(UIAlertAction(title: title, style: .default) { _ in
            cell.setGrade(grade: grade)
        })
    }
}

extension CoursesEstimatingViewController: CoursesEstimatingViewInput {
    func setupCourses(lastCourses: [StudentCourseModel], currentCourses: [StudentCourseModel], unusedCourses: [StudentCourseModel]) {
        self.lastCourses = lastCourses
        self.currentCourses = currentCourses
        self.unusedCourses = unusedCourses
        
        if courses.count == 0 || page == 1 {
            switch page {
            case 1:
                courses = currentCourses
                coursesTableView.reloadData()
            case 2:
                courses = lastCourses
                coursesTableView.reloadData()
            case 3:
                courses = unusedCourses
                coursesTableView.reloadData()
            default:
                break
            }
        }
    }
}

extension CoursesEstimatingViewController: SelectorDelegate {
    func select(at index: Int, sender: SelectorView) {
        switch index {
        case 0:
            subTitleLabel.text = "Текущий семестр"
            page = 1
            courses = currentCourses
            coursesTableView.reloadData()
        case 1:
            subTitleLabel.text = "Прошлые семестры"
            page = 2
            courses = lastCourses
            coursesTableView.reloadData()
        case 2:
            subTitleLabel.text = "Закрытые, но не проставленные курсы"
            page = 3
            courses = unusedCourses
            coursesTableView.reloadData()
        default:
            break
        }
    }
}

extension CoursesEstimatingViewController: CourseEstimatingDelegate {
    func setGrade(cell: CourseEstimationCell) {
        showTypesAlert(cell: cell)
    }
    
    func estimate(courseID: Int, grade: Int, isRetake: Bool) {
        output.setGrade(courseId: courseID, grade: grade, isRetake: isRetake)
    }
}

extension CoursesEstimatingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CourseEstimationCell", for: indexPath) as? CourseEstimationCell else {
            fatalError("Cannot create CourseEstimationCell")
        }
        cell.configure(with: courses[indexPath.row])
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
}


