//
//  CoursesAgregationViewController.swift
//  App1C
//
//  Created by Станислава on 16.04.2024.
//

import UIKit

class CoursesAgregationViewController: UIViewController {
    
    private lazy var scrollView = UIScrollView()
    private lazy var finishEstimatingButton = UIButton()
    private lazy var descriptionLabel = UILabel()
    private lazy var titleLabel = UILabel()
    private lazy var personsView = UIView()
    private lazy var personTableView = UITableView()
    private lazy var persons: [CourseAgregationModel] = []
    
    private var output: CoursesAgregationViewOutput

    init(output: CoursesAgregationViewOutput) {
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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        (navigationController as? CustomNavigationController)?.hideBackButton()
    }
    
    private func setupTitle() {
        titleLabel = TitleView(frame: CGRect(x: 30, y: 25, width: view.frame.width - 60, height: 30), title: "Запуск курсов")
        view.addSubview(titleLabel)
    }
    
    private func setupTableView() {
        personTableView.register(CourseAgregationCell.self, forCellReuseIdentifier: "CourseAgregationCell")
        personTableView.delegate = self
        personTableView.dataSource = self
        
        personsView = TableView(
            contentView: view,
            frame: view.frame,
            title: "",
            tableView: personTableView,
            margin: 0
        )
        
        personsView.backgroundColor = .systemGray6
        personTableView.backgroundColor = .systemGray6
        personTableView.layer.borderColor = UIColor.clear.cgColor
        personTableView.separatorColor = UIColor.clear
        
        scrollView.addSubview(personsView)
        personsView.addSubview(personTableView)
        personsView.translatesAutoresizingMaskIntoConstraints = false
        personTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            personTableView.heightAnchor.constraint(equalToConstant: 10000),
            personsView.heightAnchor.constraint(equalTo: personTableView.heightAnchor, constant: 30),
            personsView.bottomAnchor.constraint(equalTo: personTableView.bottomAnchor, constant: 15),
            personsView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: -10)
        ])
        
        scrollView.contentSize.height = CGFloat(persons.count * 80 - 80)
    }
    
    private func setupFinishEstimatingButton() {
        let y = tabBarController?.tabBar.frame.minY ?? view.frame.maxY
        finishEstimatingButton = ButtonView(frame: CGRect(x: 25, y: y - 100, width: view.frame.width - 50, height: 45))
        view.addSubview(finishEstimatingButton)
        finishEstimatingButton.setTitle("Запустить", for: .normal)
        
        view.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = "Запустить все курсы,\nгде набралось 5 очных студентов:"
        descriptionLabel.textColor = .black
        descriptionLabel.font = .systemFont(ofSize: 16)
        descriptionLabel.numberOfLines = 2
        descriptionLabel.textAlignment = .center
        NSLayoutConstraint.activate([
            descriptionLabel.bottomAnchor.constraint(equalTo: finishEstimatingButton.topAnchor, constant: -10),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40)
        ])
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.backgroundColor = .systemGray6
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -20)
        ])
                
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: 0)
        scrollView.isScrollEnabled = true
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
}

extension CoursesAgregationViewController: CoursesAgregationViewInput {
    func updateCourses(courses: [CourseAgregationModel]) {
        self.persons = courses
        scrollView.contentSize.height = CGFloat(persons.count * 80 - 80)
        personTableView.reloadData()
    }
}

extension CoursesAgregationViewController: SelectItemDelegate {
    func selectItem(id: Int) {
        output.selectCourse(id: id, isSelect: true)
    }
    
    func unSelectItem(id: Int) {
        output.selectCourse(id: id, isSelect: false)
    }
}

extension CoursesAgregationViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CourseAgregationCell", for: indexPath) as? CourseAgregationCell else {
            fatalError("Cannot create CourseAgregationCell")
        }
        cell.configure(with: persons[indexPath.row])
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
