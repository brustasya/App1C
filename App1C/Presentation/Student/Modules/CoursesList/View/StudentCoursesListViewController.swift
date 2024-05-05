//
//  StudentCoursesListViewController.swift
//  App1C
//
//  Created by Станислава on 02.04.2024.
//

import UIKit

class StudentCoursesListViewController: UIViewController {
    
    private lazy var scrollView = UIScrollView()
    
    private lazy var closedCoursesBackgroundView = UIView()
    private lazy var closedCoursesTableView = UITableView()
    private lazy var closedCoursesButton = UIButton(type: .system)
    private lazy var closedCoursesState: ListState = .open
    private var closedCourseConstraint: NSLayoutConstraint?
    private lazy var closedCourses: [StudentCourseModel] = []
    
    private lazy var currentCoursesBackgroundView = UIView()
    private lazy var currentCoursesTableView = UITableView()
    private lazy var currentCoursesButton = UIButton(type: .system)
    private lazy var currentCoursesState: ListState = .open
    private var currentCourseConstraint: NSLayoutConstraint?
    private lazy var currentCourses: [StudentCourseModel] = []
    
    private var output: StudentCoursesListViewOutput

    init(output: StudentCoursesListViewOutput) {
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
        setupClosedCourses()
        setupCurrentCourses()
//        closedCoursesButtonTapped()
//        currentCoursesButtonTapped()
      //  output.viewIsReady()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        (navigationController as? CustomNavigationController)?.hideBackButton()
        tabBarController?.tabBar.isTranslucent = false
        tabBarController?.tabBar.isHidden = false
        output.viewIsReady()
        let height = CGFloat(closedCourses.count * 100 + currentCourses.count * 100 + 200)
        scrollView.contentSize.height = height
    }
    
//    override func beginAppearanceTransition(_ isAppearing: Bool, animated: Bool) {
//        super.beginAppearanceTransition(isAppearing, animated: animated)
//        if isAppearing {
//
//        }
//    }
    
    private func setupScrollView() {
        scrollView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
       // scrollView.contentSize = CGSize(width: scrollView.frame.width, height: view.frame.height)
        scrollView.isScrollEnabled = true
    }

    private func setupClosedCourses() {
        closedCoursesTableView.register(ClosedCourseCell.self, forCellReuseIdentifier: "ClosedCourseCell")
        closedCoursesTableView.delegate = self
        closedCoursesTableView.dataSource = self
        
        closedCoursesBackgroundView = TableView(
            contentView: scrollView,
            frame: scrollView.frame,
            title: "Закрытые курсы",
            tableView: closedCoursesTableView,
            button: closedCoursesButton
        )
        
        closedCoursesBackgroundView.backgroundColor = .systemGray6
        
        scrollView.addSubview(closedCoursesBackgroundView)
        closedCoursesBackgroundView.addSubview(closedCoursesTableView)
        closedCoursesBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        closedCoursesTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            closedCoursesBackgroundView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 25),
            closedCoursesBackgroundView.heightAnchor.constraint(equalTo: closedCoursesTableView.heightAnchor, constant: 60),
            closedCoursesBackgroundView.bottomAnchor.constraint(equalTo: closedCoursesTableView.bottomAnchor, constant: 15)
        ])
        
        closedCourseConstraint = closedCoursesTableView.heightAnchor.constraint(equalToConstant: CGFloat(closedCourses.count * 100))
        closedCourseConstraint?.isActive = true
        closedCoursesButton.addTarget(self, action: #selector(closedCoursesButtonTapped), for: .touchUpInside)
      //  closedCoursesButtonTapped()
    }
    
    private func setupCurrentCourses() {
        currentCoursesTableView.register(ClosedCourseCell.self, forCellReuseIdentifier: "CurrentCourseCell")
        currentCoursesTableView.delegate = self
        currentCoursesTableView.dataSource = self
        
        currentCoursesBackgroundView = TableView(
            contentView: scrollView,
            frame: scrollView.frame,
            title: "Текущие курсы",
            tableView: currentCoursesTableView,
            button: currentCoursesButton
        )
              
        scrollView.addSubview(currentCoursesBackgroundView)
        currentCoursesBackgroundView.addSubview(currentCoursesTableView)
        currentCoursesBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        currentCoursesTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            currentCoursesBackgroundView.topAnchor.constraint(equalTo: closedCoursesBackgroundView.bottomAnchor, constant: 20),
            currentCoursesBackgroundView.heightAnchor.constraint(equalTo: currentCoursesTableView.heightAnchor, constant: 60),
            currentCoursesBackgroundView.bottomAnchor.constraint(equalTo: currentCoursesTableView.bottomAnchor, constant: 15)
        ])
        
        currentCourseConstraint = currentCoursesTableView.heightAnchor.constraint(equalToConstant: CGFloat(currentCourses.count * 100))
        currentCourseConstraint?.isActive = true
        currentCoursesButton.addTarget(self, action: #selector(currentCoursesButtonTapped), for: .touchUpInside)
      //  currentCoursesButtonTapped()
    }
    
    @objc private func closedCoursesButtonTapped() {
        switch closedCoursesState {
        case .open:
            closedCoursesButton.setImage(Images.down.uiImage, for: .normal)
            closedCourseConstraint?.isActive = false
            closedCoursesState = .close
            scrollView.contentSize.height -= CGFloat(closedCourses.count * 100)
        case .close:
            closedCoursesButton.setImage(Images.up.uiImage, for: .normal)
            closedCourseConstraint?.isActive = true
            closedCoursesState = .open
            scrollView.contentSize.height += CGFloat(closedCourses.count * 100)
        }
    }
    
    @objc private func currentCoursesButtonTapped() {
        switch currentCoursesState {
        case .open:
            currentCoursesButton.setImage(Images.down.uiImage, for: .normal)
            currentCourseConstraint?.isActive = false
            currentCoursesState = .close
            scrollView.contentSize.height -= CGFloat(currentCourses.count * 100)
            return
        case .close:
            currentCoursesButton.setImage(Images.up.uiImage, for: .normal)
            currentCourseConstraint?.isActive = true
            currentCoursesState = .open
            scrollView.contentSize.height += CGFloat(currentCourses.count * 100)
            return
        }
    }
}

extension StudentCoursesListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == closedCoursesTableView {
            return closedCourses.count
        } else {
            return currentCourses.count
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == closedCoursesTableView {
            output.selectClosedCourse(at: indexPath.row)
        } else {
            output.selectCurrentCourse(at: indexPath.row)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == closedCoursesTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ClosedCourseCell", for: indexPath) as? ClosedCourseCell else {
                fatalError("Cannot create ClosedCourseCell")
            }
            cell.configure(with: closedCourses[indexPath.row])
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CurrentCourseCell", for: indexPath) as? ClosedCourseCell else {
                fatalError("Cannot create CurrentCourseCell")
            }
            cell.configure(with: currentCourses[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == closedCoursesTableView {
            return 100
        } else {
            return 100
        }
    }
}

extension StudentCoursesListViewController: StudentCoursesListViewInput {
    func setupCourses(closedCourses: [StudentCourseModel], currentCourses: [StudentCourseModel]) {
        self.closedCourses = closedCourses
        self.currentCourses = currentCourses
        setupClosedCourses()
        setupCurrentCourses()
        let height = CGFloat(closedCourses.count * 100 + currentCourses.count * 100 + 200)
        scrollView.contentSize.height = height
        closedCoursesButtonTapped()
        currentCoursesButtonTapped()
    }
    
    func updateCourses(closedCourses: [StudentCourseModel], currentCourses: [StudentCourseModel]) {
        self.closedCourses = closedCourses
        self.currentCourses = currentCourses

        closedCourseConstraint?.isActive = false
        closedCourseConstraint = closedCoursesTableView.heightAnchor.constraint(equalToConstant: CGFloat(closedCourses.count * 100))
        closedCourseConstraint?.isActive = true
        closedCoursesTableView.reloadData()
        
        currentCourseConstraint?.isActive = false
        currentCourseConstraint = currentCoursesTableView.heightAnchor.constraint(equalToConstant: CGFloat(currentCourses.count * 100))
        currentCourseConstraint?.isActive = true
        currentCoursesTableView.reloadData()
        
        let height = CGFloat(closedCourses.count * 100 + currentCourses.count * 100 + 200)
        scrollView.contentSize.height = height
        
        currentCoursesButton.setImage(Images.up.uiImage, for: .normal)
        closedCoursesButton.setImage(Images.up.uiImage, for: .normal)

//        closedCoursesButtonTapped()
//        currentCoursesButtonTapped()
    }
}
