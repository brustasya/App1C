//
//  FinalCourseSelectionViewController.swift
//  App1C
//
//  Created by Станислава on 19.04.2024.
//

import UIKit

class FinalCourseSelectionViewController: UIViewController {
    
//    private var output: StudentSettingsViewOutput
//
//    init(output: StudentSettingsViewOutput) {
//        self.output = output
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
    private lazy var titleLabel = UILabel()
    private lazy var subTitleLabel = UILabel()
    private lazy var scrollView = UIScrollView()
    private lazy var chooseButton = UIButton()
    private lazy var pageControl = UIView()
    private let requaredAmount = 3
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
    private lazy var amountLable = UILabel()
    private lazy var courseViews: [CourseView: CourseSelectionViewModel] = [:]
    private lazy var selectedCourses: [CourseSelectedModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let s5 = CourseSelectionServiceModel(id: 5, title: "Аналитическая геометрия", dependencies: [], closed: false, wasInLoad: false)
        let s1 = CourseSelectionServiceModel(id: 1, title: "Математический анализ", dependencies: [], closed: true, wasInLoad: true)
        let s2 = CourseSelectionServiceModel(id: 2, title: "Операционные системы", dependencies: [DependenceModel(id: 5, title: "Аналитическая геометрия", closed: false)], closed: false, wasInLoad: false)
        let s3 = CourseSelectionServiceModel(id: 3, title: "Программирование", dependencies: [DependenceModel(id: 1, title: "Математический анализ", closed: true)], closed: true, wasInLoad: false)
        let s4 = CourseSelectionServiceModel(id: 4, title: "Линейная алгебра", dependencies: [DependenceModel(id: 3, title: "Программирование", closed: true), DependenceModel(id: 2, title: "Операционные системы", closed: false)], closed: false, wasInLoad: false)
        
//        let s5 = CourseSelectionServiceModel(id: 5, title: "Аналитическая геометрия", closed: false, wasInLoad: false, dependencies: [])
//        let s1 = CourseSelectionServiceModel(id: 1, title: "Математический анализ", closed: true, wasInLoad: true, dependencies: [DependenceModel(id: 5, title: "Аналитическая геометрия", closed: false)])
//        let s2 = CourseSelectionServiceModel(id: 2, title: "Операционные системы", closed: false, wasInLoad: false, dependencies: [])
//        let s3 = CourseSelectionServiceModel(id: 3, title: "Программирование", closed: true, wasInLoad: false, dependencies: [])
//        let s4 = CourseSelectionServiceModel(id: 4, title: "Линейная алгебра", closed: false, wasInLoad: false, dependencies: [DependenceModel(id: 3, title: "Программирование", closed: true), DependenceModel(id: 2, title: "Операционные системы", closed: false)])
        let serviceModels = [s1, s2, s5, s3, s4]
        
        let c1 = CourseSelectionModel(id: 1, title: "A", closed: true, wasInLoad: true, courseChildren: [])
        let c2 = CourseSelectionModel(id: 2, title: "B", closed: false, wasInLoad: false, courseChildren: [])
        let c3 = CourseSelectionModel(id: 3, title: "C", closed: true, wasInLoad: false, courseChildren: [c1])
        let c4 = CourseSelectionModel(id: 4, title: "D", closed: true, wasInLoad: true, courseChildren: [c2, c3])
        c1.parentCourse = c3
        c2.parentCourse = c4
        c3.parentCourse = c4
     //   let courses = [c1, c2, c3, c4]
        
        treeBuilder(serviceModels: serviceModels)
        setupView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isTranslucent = true
        tabBarController?.tabBar.isHidden = true
    }
    
    var coursesDict: [Int: CourseSelectionModel] = [:]
    private func treeBuilder(serviceModels: [CourseSelectionServiceModel]) {
        for model in serviceModels {
            let course = CourseSelectionModel(id: model.id, title: model.title, closed: model.closed ?? false, wasInLoad: model.wasInLoad ?? false)
            coursesDict[model.id] = course
        }
        for model in serviceModels {
            let parent = coursesDict[model.id]
            for dep in model.dependencies {
                if let course = coursesDict[dep.id] {
                    course.parentCourse = parent
                    parent?.courseChildren.append(course)
                } else {
                    let course = CourseSelectionModel(id: dep.id, title: dep.title, closed: dep.closed)
                    coursesDict[dep.id] = course
                }
            }
        }
    }
    
    private func setupView() {
        view.addSubview(scrollView)
        
        titleLabel = TitleView(frame: CGRect(x: 30, y: 25, width: view.frame.width, height: 30), title: "Выбор курсов")
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
        
        setupSubTitle()
        
        var y: CGFloat = 0//titleLabel.frame.maxY
        var deps: [CourseView] = []
        var cur: [CourseView] = []
        let courses: [CourseSelectionModel] = Array(coursesDict.values)
        setupCourses(courses: courses, x: 20, y: &y, deps: &deps, currentDeps: &cur)
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
        setupChooseButton()
        setupPageControl()
        setupScrollView()
        for courses in courseViews {
            print(courses.key.courseID, " : ", coursesDict[courses.key.courseID]?.parentCourse?.id)
            for course in courses.value.allDeps {
                print(course.courseID)
            }
        }
    }
    
    private func setupSubTitle() {
        view.addSubview(subTitleLabel)
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.textColor = .black
        subTitleLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        subTitleLabel.text = "Выбранные курсы"
        subTitleLabel.numberOfLines = 2
        
        NSLayoutConstraint.activate([
            subTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            subTitleLabel.topAnchor.constraint(equalTo: amountLable.bottomAnchor, constant: 15),
            subTitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -30)
        ])
    }
    
    private func setupScrollView() {
        scrollView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 10),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -170)
        ])
                
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: 0)
        scrollView.isScrollEnabled = true
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
    private func setupCourses(courses: [CourseSelectionModel], x: CGFloat, y: inout CGFloat, deps: inout [CourseView], currentDeps: inout [CourseView]) {
        var previousView: CourseView? = nil
        for course in courses {
            y += 10
            let courseView = CourseView(frame: CGRect(x: x, y: y, width: view.frame.width - x - 20, height: 60))
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
            setupCourses(courses: course.courseChildren, x: x + 20, y: &y, deps: &newDeps, currentDeps: &cur)
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
    
    private func setupPageControl() {
        let pages = ["1", "2", "3"]
        pageControl = SelectorView(
            frame: CGRect(x: view.frame.midX - 75, y: chooseButton.frame.minY - 70, width: 150, height: 50),
            buttonsTitles: pages,
            delegate: self
        )
        view.addSubview(pageControl)
    }
    
    @objc func chooseButtonTapped() {
        for course in selectedCourses {
            print(course)
        }
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


extension FinalCourseSelectionViewController: CourseSelecitonDelegate {
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

extension FinalCourseSelectionViewController: SelectorDelegate {
    func select(at index: Int) {
        switch index {
        case 0:
            subTitleLabel.text = "Выбранные курсы"
        case 1:
            subTitleLabel.text = "Закрытые, но не проставленные курсы"
        case 2:
            subTitleLabel.text = "Остальные запущенные курсы"
        default:
            return
        }
    }
    
    
}
//extension StudentSettingsViewController: StudentSettingsViewInput {
//
//}
//
//extension StudentSettingsViewController {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        output.selectRowAt(index: indexPath.row)
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//}
//

