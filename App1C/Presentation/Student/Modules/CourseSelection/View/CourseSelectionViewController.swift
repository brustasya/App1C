//
//  CourseSelectionViewController.swift
//  App1C
//
//  Created by Станислава on 10.04.2024.
//

import UIKit

class CourseSelectionViewController: UIViewController {
    
    private var output: CourseSelectionViewOutput

    init(output: CourseSelectionViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var scrollView = UIScrollView()
    private lazy var chooseButton = UIButton()
    private lazy var amountLable = UILabel()
    private lazy var courseViews: [CourseView: CourseSelectionViewModel] = [:]
    private lazy var selectedCourses: [CourseSelectedModel] = []
    private lazy var coursesDict: [Int: CourseSelectionModel] = [:]
    
    private var requaredAmount = 3
    private lazy var amount = 3 {
        didSet {
            amountLable.text = amount < 0 ? "0" : "\(amount)"
            chooseButton.isUserInteractionEnabled = amount <= 0
            chooseButton.backgroundColor = amount <= 0 ? Colors.yellow.uiColor : .systemGray6
        }
    }
    private lazy var countOfOpenCourses = 0 {
        didSet {
            scrollView.contentSize.height = CGFloat(countOfOpenCourses * 70 + 40)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupView()
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
        
    private func setupView() {
        view.addSubview(scrollView)
        
        let titleLabel = TitleView(frame: CGRect(x: 30, y: 25, width: view.frame.width, height: 30), title: "Выбор курсов")
        view.addSubview(titleLabel)
        
        let amountDescrLabel = UILabel()
        amountDescrLabel.text = "Нужно выбрать еще хотя бы:"
        amountDescrLabel.textColor = .black
        amountDescrLabel.font = .systemFont(ofSize: 17, weight: .regular)
        amountLable.text = "\(amount)"
        amountLable.textColor = .black
        amountLable.font = .systemFont(ofSize: 17, weight: .regular)
        view.addSubview(amountDescrLabel)
        view.addSubview(amountLable)
        amountLable.translatesAutoresizingMaskIntoConstraints = false
        amountDescrLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            amountDescrLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            amountDescrLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            amountLable.centerYAnchor.constraint(equalTo: amountDescrLabel.centerYAnchor),
            amountLable.leadingAnchor.constraint(equalTo: amountDescrLabel.trailingAnchor, constant: 20)
        ])
        
        setupChooseButton()
        setupScrollView()
//        for courses in courseViews {
//            print(courses.key.courseID, " : ", coursesDict[courses.key.courseID]?.parentCourse?.id)
//            for course in courses.value.allDeps {
//                print(course.courseID)
//            }
//        }
    }
    
    private func setupScrollView() {
        scrollView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: amountLable.bottomAnchor, constant: 17),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
                
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: 0)
        scrollView.isScrollEnabled = true
    }
    
    private func setupCourses() {
        var y: CGFloat = 0
        var deps: [CourseView] = []
        var cur: [CourseView] = []
        let courses: [CourseSelectionModel] = Array(coursesDict.values)
        setupCoursesViews(courses: courses, x: 20, y: &y, deps: &deps, currentDeps: &cur)
        countOfOpenCourses = courseViews.count
        
        for course in coursesDict.values {
            if course.closed {
                if let views = course.parentCourse?.views {
                    for courseView in views {
                        courseView.countOfSelectedDeps += 1
                    }
                }
            }
        }
        
        for course in courseViews {
            course.value.allDeps = getAllDeps(for: course.key)
        }
        
        for course in courseViews.keys {
            scrollView.addSubview(course)
            course.y = course.frame.maxY
        }
        
        for course in courseViews.keys {
            if course.countOfDependencies > 0 {
                closeDependencies(view: course)
            }
        }
    }
    
    private func getDeps(for course: CourseSelectionModel) -> [CourseSelectionModel] {
        var deps = course.courseChildren
        for dep in course.courseChildren {
            deps += getDeps(for: dep)
        }
        return deps
    }
    
    private func getAllDeps(for courseView: CourseView) -> [CourseView] {
        if let depViews = courseViews[courseView]?.deps {
            var deps = depViews
            for dep in depViews {
                deps += getAllDeps(for: dep)
            }
            return deps
        }
        return []
    }
    
    var id = 0
    private func setupCoursesViews(courses: [CourseSelectionModel], x: CGFloat, y: inout CGFloat, deps: inout [CourseView], currentDeps: inout [CourseView]) {
        var previousView: CourseView? = nil
        for course in courses {
            y += 10
            let courseView = CourseView(
                frame: CGRect(x: x, y: y, width: view.frame.width - x - 20, height: 60)
            )
            courseView.configure(with: course)
            courseView.delegate = self
            courseView.id = id
            id += 1
            course.views.append(courseView)
            currentDeps.append(courseView)
            deps.append(courseView)
            if let previousView {
                courseViews[previousView]?.nextView = courseView
            }
            previousView = courseView
            y = courseView.frame.maxY
            var newDeps: [CourseView] = []
            var cur: [CourseView] = []
            setupCoursesViews(
                courses: course.courseChildren, x: x + 20, y: &y, deps: &newDeps, currentDeps: &cur
            )
            courseViews[courseView] = CourseSelectionViewModel(allDeps: newDeps, deps: cur)
            deps += newDeps
        }
    }
    
    private func setupChooseButton() {
        let y = tabBarController?.tabBar.frame.minY ?? view.frame.maxY
        chooseButton = ButtonView(frame: CGRect(x: 25, y: y - 95, width: view.frame.width - 50, height: 45))
        view.addSubview(chooseButton)
        chooseButton.setTitle("Выбрать", for: .normal)
        chooseButton.isUserInteractionEnabled = amount == 0
        chooseButton.backgroundColor = amount == 0 ? Colors.yellow.uiColor : .systemGray6
        chooseButton.addTarget(self, action: #selector(chooseButtonTapped), for: .touchUpInside)
    }
    
    @objc func chooseButtonTapped() {
        output.chooseButtonTapped(selectedCorses: selectedCourses)
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    private func select(id: Int, isOffline: Bool) {
        if let course = coursesDict[id] {
            for courseView in course.views {
                courseView.select(isOffline: isOffline)
            }
            if !course.closed {
                if let views = course.parentCourse?.views {
                    for view in views {
                        view.countOfSelectedDeps += 1
                    }
                }
            }
        }
        for course in selectedCourses {
            if course.id == id {
                return
            }
        }
        selectedCourses.append(CourseSelectedModel(id: id, takenAsLoad: false, isOffline: isOffline))
        amount = requaredAmount - selectedCourses.count
    }
    
    private func unSelect(id: Int) {
        if let course = coursesDict[id] {
            for courseView in course.views {
                courseView.unSelect()
            }
            if !course.closed {
                if let parent = course.parentCourse {
                    for view in parent.views {
                        view.countOfSelectedDeps -= 1
                    }
                    unselectCourse(id: parent.id)
                }
            }
        }
        selectedCourses = selectedCourses.filter({!($0.id == id)})
        amount = requaredAmount - selectedCourses.count
    }
    
}

extension CourseSelectionViewController: CourseSelecitonDelegate {
    func openDependencies(view: CourseView) {
        if let deps = courseViews[view]?.deps {
            for courseView in courseViews.keys {
                if courseView.y > view.y && !(courseViews[view]?.allDeps.contains(courseView) ?? true) {
                    print("Move down", courseView.courseID, " \(courseView.id)")
                    courseView.frame.origin.y += CGFloat(deps.count * 70)
                }
            }
            for dep in deps {
                dep.isHidden = false
                dep.isOpen = true
                print("Open ", dep.courseID," \(dep.id)")
                countOfOpenCourses += 1
            }
        }
    }
    
    func closeDependencies(view: CourseView) {
        if let deps = courseViews[view]?.deps {
            print("close deps for \(view.courseID)")
            for dep in deps {
                if dep.countOfDependencies > 0 && dep.isOpen {
                    closeDependencies(view: dep)
                }
            }
            var countOfCloseDeps = 0
            for dep in deps {
                if dep.isOpen {
                    countOfCloseDeps += 1
                    dep.isHidden = true
                    dep.isOpen = false
                    print("Close ", dep.courseID, " \(dep.id)")
                    countOfOpenCourses -= 1
                }
            }
            
            for courseView in courseViews.keys {
                if courseView.y > view.y && !(courseViews[view]?.allDeps.contains(courseView) ?? true) {
                    print("Move up", courseView.courseID, " \(courseView.id)", "for \(countOfCloseDeps)")
                    courseView.frame.origin.y -= CGFloat(countOfCloseDeps * 70)
                }
            }
        }
    }
    
    func selectCourse(id: Int) {
        if coursesDict[id]?.closed ?? false {
            select(id: id, isOffline: false)
            return
        }
        let title = coursesDict[id]?.title ?? ""
        let alertController = UIAlertController(title: title, message: "Как вы хотите проходить курс?", preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: "Очно", style: .default, handler: { [weak self] _ in
            self?.select(id: id, isOffline: true)
        }))

        alertController.addAction(UIAlertAction(title: "Экстерн", style: .default, handler: { [weak self] _  in
            self?.select(id: id, isOffline: false)
        }))

        alertController.view.backgroundColor = Colors.paleYellow.uiColor
        alertController.view.tintColor = .black
        alertController.view.layer.cornerRadius = 15
        
        present(alertController, animated: true, completion: nil)

    }
    
    func unselectCourse(id: Int) {
        unSelect(id: id)
    }
}

extension CourseSelectionViewController: CourseSelectionViewInput {
    func updateCourses(coursesDict: [Int: CourseSelectionModel]) {
        self.coursesDict = coursesDict
        setupCourses()
    }
    
    func setupAmount(amount: Int) {
        requaredAmount = amount
        self.amount = amount
    }
    
    func close() {
        goBack()
    }
}
