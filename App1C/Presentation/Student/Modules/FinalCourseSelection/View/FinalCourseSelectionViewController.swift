//
//  FinalCourseSelectionViewController.swift
//  App1C
//
//  Created by Станислава on 19.04.2024.
//

import UIKit

class FinalCourseSelectionViewController: UIViewController {
    
    private var output: FinalCourseSelectionViewOutput

    init(output: FinalCourseSelectionViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var titleLabel = UILabel()
    private lazy var subTitleLabel = UILabel()
    
    private lazy var choosenScrollView = UIScrollView()
    private lazy var closedScrollView = UIScrollView()
    private lazy var startedScrollView = UIScrollView()
    
    private lazy var coursesView = UIView()
    private lazy var coursesTableView = UITableView()
    private lazy var courses: [AddDependenceModel] = []
    
    var choosenCoursesDict: [Int: ChoosenCourseSelectionModel] = [:]
    var startedCoursesDict: [Int: CourseSelectionModel] = [:]
    var closedCourses: [AddDependenceModel] = []
    
    private lazy var choosenCourseViews: [ChoosenCourseView: ChoosenCourseSelectionViewModel] = [:]
    private lazy var startedCourseViews: [CourseView: CourseSelectionViewModel] = [:]
    
    private lazy var chooseButton = UIButton()
    private lazy var pageControl = UIView()
    
    private lazy var amountLable = UILabel()
    private var requaredAmount = 0
    private lazy var amount = 0 {
        didSet {
            amountLable.text = amount < 0 ? "0" : "\(amount)"
            chooseButton.isUserInteractionEnabled = amount <= 0
            chooseButton.backgroundColor = amount <= 0 ? Colors.yellow.uiColor : .systemGray6
        }
    }
    private lazy var countOfOpenStartesCourses = 0 {
        didSet {
            startedScrollView.contentSize.height = CGFloat(countOfOpenStartesCourses * 80 + 40)
        }
    }
    private lazy var countOfOpenChoosenCourses = 0 {
        didSet {
            choosenScrollView.contentSize.height = CGFloat(countOfOpenStartesCourses * 80 + 40)
        }
    }
    
    private lazy var selectedCourses: [CourseSelectedModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupView()
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
    
    private func treeBuilder(serviceModels: [CourseSelectionServiceModel]) {
        for model in serviceModels {
            let course = CourseSelectionModel(id: model.id, title: model.title, closed: model.closed ?? false, wasInLoad: model.wasInLoad ?? false)
            startedCoursesDict[model.id] = course
        }
        for model in serviceModels {
            let parent = startedCoursesDict[model.id]
            for dep in model.dependencies {
                if let course = startedCoursesDict[dep.id] {
                    course.parentCourse = parent
                    parent?.courseChildren.append(course)
                } else {
                    let course = CourseSelectionModel(id: dep.id, title: dep.title, closed: dep.closed)
                    startedCoursesDict[dep.id] = course
                }
            }
        }
    }
    
    private func setupView() {
        view.addSubview(choosenScrollView)
        view.addSubview(startedScrollView)
        view.addSubview(closedScrollView)
        
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
        setupChooseButton()
        setupPageControl()
        setupScrollView()
        output.viewIsReady()
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
        createScrollView(scrollView: choosenScrollView)
        createScrollView(scrollView: closedScrollView)
        createScrollView(scrollView: startedScrollView)
    }
    
    private func createScrollView(scrollView: UIScrollView) {
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
        scrollView.isHidden = true
    }
    
    private func setupStartedCourses() {
        var y: CGFloat = 0
        var cur: [CourseView] = []
        let courses: [CourseSelectionModel] = Array(startedCoursesDict.values)
        setupStartedCoursesViews(courses: courses, x: 20, y: &y, currentDeps: &cur, isDeps: false)
        countOfOpenStartesCourses = startedCourseViews.count
        
        for course in startedCourseViews {
            course.value.allDeps = getAllDeps(for: course.key)
        }
        
        for course in startedCourseViews.keys {
            course.setupCountOfDeps()
            startedScrollView.addSubview(course)
            course.y = course.frame.maxY
        }
        
        for course in startedCourseViews.keys {
            if course.countOfDependencies > 0 {
                closeDependencies(view: course)
            }
        }
    }
    
    private func setupChoosenCourses() {
        var y: CGFloat = 0
        var cur: [ChoosenCourseView] = []
        let courses: [ChoosenCourseSelectionModel] = Array(choosenCoursesDict.values)
        setupChoosenCoursesViews(courses: courses, x: 20, y: &y, currentDeps: &cur, isDeps: false)
        countOfOpenChoosenCourses = choosenCourseViews.count
        
        for course in choosenCourseViews {
            course.value.allDeps = getAllDeps(for: course.key)
        }
        
        for course in choosenCourseViews.keys {
            choosenScrollView.addSubview(course)
            course.y = course.frame.maxY
        }
        
        for course in choosenCourseViews.keys {
            if course.countOfDependencies > 0 {
                closeChoosenDependencies(view: course)
            }
        }
    }
    
    private func getAllDeps(for courseView: CourseView) -> [CourseView] {
        if let depViews = startedCourseViews[courseView]?.deps {
            var deps = depViews
            for dep in depViews {
                deps += getAllDeps(for: dep)
            }
            return deps
        }
        return []
    }
    
    private func getAllDeps(for courseView: ChoosenCourseView) -> [ChoosenCourseView] {
        if let depViews = choosenCourseViews[courseView]?.deps {
            var deps = depViews
            for dep in depViews {
                deps += getAllDeps(for: dep)
            }
            return deps
        }
        return []
    }
    
    
    var startedCoursesID = 0
    private func setupStartedCoursesViews(courses: [CourseSelectionModel], x: CGFloat, y: inout CGFloat, currentDeps: inout [CourseView], isDeps: Bool) {
        
        for course in courses {
            y += 10
            let courseView = CourseView(
                frame: CGRect(x: x, y: y, width: view.frame.width - x - 20, height: 70)
            )
            courseView.isDep = isDeps
            courseView.configure(with: course)
            courseView.delegate = self
            courseView.id = startedCoursesID
            startedCoursesID += 1
            course.views.append(courseView)
            currentDeps.append(courseView)
            
            y = courseView.frame.maxY
            var cur: [CourseView] = []
            
            setupStartedCoursesViews(
                courses: course.courseChildren, x: x + 20, y: &y, currentDeps: &cur, isDeps: true
            )
            
            startedCourseViews[courseView] = CourseSelectionViewModel(allDeps: cur, deps: cur)
        }
    }
    
    
    var choosenCoursesID = 0
    private func setupChoosenCoursesViews(courses: [ChoosenCourseSelectionModel], x: CGFloat, y: inout CGFloat, currentDeps: inout [ChoosenCourseView], isDeps: Bool) {
        
        for course in courses {
            y += 10
            let courseView = ChoosenCourseView(frame: CGRect(x: x, y: y, width: view.frame.width - x - 20, height: 70))
            courseView.isDep = isDeps
            courseView.configure(with: course)
            courseView.delegate = self
            courseView.id = choosenCoursesID
            choosenCoursesID += 1
            course.views.append(courseView)
            currentDeps.append(courseView)
            
            y = courseView.frame.maxY
            var cur: [ChoosenCourseView] = []
            
            setupChoosenCoursesViews(courses: course.courseChildren, x: x + 20, y: &y, currentDeps: &cur, isDeps: true)
            
            choosenCourseViews[courseView] = ChoosenCourseSelectionViewModel(allDeps: cur, deps: cur)
        }
    }
    
    private func setupClosedCourses() {
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
        
        closedScrollView.addSubview(coursesView)
        coursesView.addSubview(coursesTableView)
        coursesView.translatesAutoresizingMaskIntoConstraints = false
        coursesTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            coursesTableView.heightAnchor.constraint(equalToConstant: CGFloat(Double(courses.count * 80))),
            coursesView.heightAnchor.constraint(equalTo: coursesTableView.heightAnchor, constant: 30),
            coursesView.bottomAnchor.constraint(equalTo: coursesTableView.bottomAnchor, constant: 15),
            coursesView.topAnchor.constraint(equalTo: closedScrollView.topAnchor, constant: -10)
        ])
        
        closedScrollView.contentSize.height = CGFloat(courses.count * 80 - 80)
    }
    
    private func select(id: Int, takenAsLoad: Bool) {
        let title = choosenCoursesDict[id]?.title ?? ""
        let alertController = UIAlertController(title: title, message: "Как вы хотите проходить курс?", preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: "Очно", style: .default, handler: { [weak self] _ in
            self?.selectedCourses.append(CourseSelectedModel(id: id, takenAsLoad: takenAsLoad, isOffline: true))
            if let course = self?.choosenCoursesDict[id] {
                for courseView in course.views {
                    courseView.select(isOffline: true, takenAsLoad: takenAsLoad)
                }
            }
        }))

        alertController.addAction(UIAlertAction(title: "Экстерн", style: .default, handler: { [weak self] _  in
            self?.selectedCourses.append(CourseSelectedModel(id: id, takenAsLoad: takenAsLoad, isOffline: false))
            if let course = self?.choosenCoursesDict[id] {
                for courseView in course.views {
                    courseView.select(isOffline: false, takenAsLoad: takenAsLoad)
                }
            }
        }))

        alertController.view.backgroundColor = Colors.paleYellow.uiColor
        alertController.view.tintColor = .black
        alertController.view.layer.cornerRadius = 15
        
        present(alertController, animated: true, completion: nil)
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
        print(selectedCourses)
        output.chooseButtonTapped(selectedCorses: selectedCourses)
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
}

extension FinalCourseSelectionViewController: ChoosenCourseSelectionDelegate {
    func getInfo(id: Int) {
        output.openCourse(id: id, navigationController: navigationController)
    }
    
    func openChoosenDependencies(view: ChoosenCourseView) {
        if let deps = choosenCourseViews[view]?.deps {
            for courseView in choosenCourseViews.keys {
                if courseView.y > view.y && !(choosenCourseViews[view]?.allDeps.contains(courseView) ?? true) {
                    courseView.frame.origin.y += CGFloat(deps.count * 80)
                }
            }
            for dep in deps {
                dep.isHidden = false
                dep.isOpen = true
                countOfOpenChoosenCourses += 1
            }
        }
    }
    
    func closeChoosenDependencies(view: ChoosenCourseView) {
        if let deps = choosenCourseViews[view]?.deps {
            for dep in deps {
                if dep.countOfDependencies > 0 && dep.isOpen {
                    closeChoosenDependencies(view: dep)
                }
            }
            var countOfCloseDeps = 0
            for dep in deps {
                if dep.isOpen {
                    countOfCloseDeps += 1
                    dep.isHidden = true
                    dep.isOpen = false
                    countOfOpenChoosenCourses -= 1
                }
            }
            
            for courseView in choosenCourseViews.keys {
                if courseView.y > view.y && !(choosenCourseViews[view]?.allDeps.contains(courseView) ?? true) {
                    courseView.frame.origin.y -= CGFloat(countOfCloseDeps * 80)
                }
            }
        }
    }
    
    func unselectChoosenCourse(id: Int) {
        let course = selectedCourses.first(where: {$0.id == id})
        if course?.takenAsLoad ?? false {
            amount += 1
        }
        selectedCourses.removeAll(where: {$0.id == id})
        if let course = choosenCoursesDict[id] {
            for courseView in course.views {
                courseView.unSelect()
            }
        }
    }
    
    func selectChoosenCourse(id: Int) {
        let title = choosenCoursesDict[id]?.title ?? ""
        let alertController = UIAlertController(title: title, message: "Как вы хотите выбрать курс?", preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: "В нагрузку", style: .default, handler: { [weak self] _ in
            if let course = self?.choosenCoursesDict[id] {
                self?.amount -= 1
                if course.isStarted && !course.isOffline {
                    self?.select(id: id, takenAsLoad: true)
                } else {
                    let isOffline = course.isStarted && course.isOffline
                    for courseView in course.views {
                        courseView.select(isOffline: isOffline, takenAsLoad: true)
                    }
                    self?.selectedCourses.append(CourseSelectedModel(id: id, takenAsLoad: true, isOffline: isOffline))
                }
            }
        }))

        alertController.addAction(UIAlertAction(title: "Не в нагрузку", style: .default, handler: { [weak self] _  in
            if let course = self?.choosenCoursesDict[id] {
                if course.isStarted && !course.isOffline {
                    self?.select(id: id, takenAsLoad: false)
                } else {
                    let isOffline = course.isStarted && course.isOffline
                    for courseView in course.views {
                        courseView.select(isOffline: isOffline, takenAsLoad: false)
                    }
                    self?.selectedCourses.append(CourseSelectedModel(id: id, takenAsLoad: false, isOffline: isOffline))
                }
            }
        }))

        alertController.view.backgroundColor = Colors.paleYellow.uiColor
        alertController.view.tintColor = .black
        alertController.view.layer.cornerRadius = 15
        
        present(alertController, animated: true, completion: nil)
    }
}

extension FinalCourseSelectionViewController: CourseSelecitonDelegate {
    func openDependencies(view: CourseView) {
        if let deps = startedCourseViews[view]?.deps {
            for courseView in startedCourseViews.keys {
                if courseView.y > view.y && !(startedCourseViews[view]?.allDeps.contains(courseView) ?? true) {
                    courseView.frame.origin.y += CGFloat(deps.count * 80)
                }
            }
            for dep in deps {
                dep.isHidden = false
                dep.isOpen = true
                countOfOpenStartesCourses += 1
            }
        }
    }
    
    func closeDependencies(view: CourseView) {
        if let deps = startedCourseViews[view]?.deps {
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
                    countOfOpenStartesCourses -= 1
                }
            }
            
            for courseView in startedCourseViews.keys {
                if courseView.y > view.y && !(startedCourseViews[view]?.allDeps.contains(courseView) ?? true) {
                 //   print("Move up", courseView.courseID, " \(courseView.id)", "for \(countOfCloseDeps)")
                    courseView.frame.origin.y -= CGFloat(countOfCloseDeps * 80)
                }
            }
        }
    }
    
    func selectCourse(id: Int) {
        let title = startedCoursesDict[id]?.title ?? ""
        let alertController = UIAlertController(title: title, message: "Как вы хотите выбрать курс?", preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: "В нагрузку", style: .default, handler: { [weak self] _ in
            self?.selectedCourses.append(CourseSelectedModel(id: id, takenAsLoad: true, isOffline: true))
            self?.amount -= 1
            if let course = self?.startedCoursesDict[id] {
                for courseView in course.views {
                    courseView.finalSelect(takenAsLoad: true)
                }
            }
        }))

        alertController.addAction(UIAlertAction(title: "Не в нагрузку", style: .default, handler: { [weak self] _  in
            self?.selectedCourses.append(CourseSelectedModel(id: id, takenAsLoad: false, isOffline: true))
            if let course = self?.startedCoursesDict[id] {
                for courseView in course.views {
                    courseView.finalSelect(takenAsLoad: false)
                }
            }
        }))

        alertController.view.backgroundColor = Colors.paleYellow.uiColor
        alertController.view.tintColor = .black
        alertController.view.layer.cornerRadius = 15
        
        present(alertController, animated: true, completion: nil)
    }
    
    func unselectCourse(id: Int) {
        let course = selectedCourses.first(where: {$0.id == id})
        if course?.takenAsLoad ?? false {
            amount += 1
        }
        selectedCourses.removeAll(where: {$0.id == id})
        if let course = startedCoursesDict[id] {
            for courseView in course.views {
                courseView.unSelect()
            }
        }
    }
}

extension FinalCourseSelectionViewController: SelectItemDelegate {
    func selectItem(id: Int) {
        selectedCourses.append(CourseSelectedModel(id: id, takenAsLoad: true, isOffline: false))
        amount -= 1
    }
    
    func unSelectItem(id: Int) {
        selectedCourses.removeAll(where: {$0.id == id})
        amount += 1
    }
}

extension FinalCourseSelectionViewController: SelectorDelegate {
    func select(at index: Int, sender: SelectorView) {
        switch index {
        case 0:
            subTitleLabel.text = "Выбранные курсы"
            choosenScrollView.isHidden = false
            closedScrollView.isHidden = true
            startedScrollView.isHidden = true
        case 1:
            subTitleLabel.text = "Закрытые, но не проставленные курсы"
            choosenScrollView.isHidden = true
            closedScrollView.isHidden = false
            startedScrollView.isHidden = true
        case 2:
            subTitleLabel.text = "Остальные запущенные курсы"
            choosenScrollView.isHidden = true
            closedScrollView.isHidden = true
            startedScrollView.isHidden = false
        default:
            return
        }
    }
}

extension FinalCourseSelectionViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return closedCourses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AddDependenceCell", for: indexPath) as? AddDependenceCell else {
            fatalError("Cannot create AddDependenceCell")
        }
        cell.configure(with: closedCourses[indexPath.row])
        cell.configureColor(color: Colors.salat.uiColor)
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension FinalCourseSelectionViewController: FinalCourseSelectionViewInput {
    func close() {
        goBack()
    }
    
    func setupCourses(
        startedCoursesDict: [Int: CourseSelectionModel],
        choosenCoursesDict: [Int: ChoosenCourseSelectionModel],
        closedCourses: [AddDependenceModel]
    ) {
        self.startedCoursesDict = startedCoursesDict
        setupStartedCourses()
        self.choosenCoursesDict = choosenCoursesDict
        setupChoosenCourses()
        self.closedCourses = closedCourses
        setupClosedCourses()
        print(startedCoursesDict)
        choosenScrollView.isHidden = false
    }
    
    func setupAmount(amount: Int) {
        requaredAmount = amount
        self.amount = amount
    }
}

//var choosenCoursesDict: [Int: ChoosenCourseSelectionModel] = [:]
//var startedCoursesDict: [Int: CourseSelectionModel] = [:]
//var closedCourses: [AddDependenceModel] = []
