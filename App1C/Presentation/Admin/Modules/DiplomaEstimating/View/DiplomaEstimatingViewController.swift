//
//  DiplomaEstimatingViewController.swift
//  App1C
//
//  Created by Станислава on 08.05.2024.
//

import UIKit

final class DiplomaEstimatingViewController: UIViewController {
    
    private lazy var titleLabel = UILabel()
    private lazy var addStudentButton = UIButton()
    private lazy var degreeSelector = UIView()
    private lazy var speechSelector = UIView()
    private lazy var studentsView = UIView()
    private lazy var studentsTableView = UITableView()
    private lazy var students: [EstimationModel] = []
    
    private var output: DiplomaEstimatingViewOutput

    init(output: DiplomaEstimatingViewOutput) {
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
        let degrees = ["Бакалавриат", "Магистратура"]
        degreeSelector = SelectorView(
            frame: CGRect(x: view.frame.midX - 160, y: 25, width: 330, height: 40),
            buttonsTitles: degrees,
            delegate: self,
            width: 150,
            color: Colors.paleYellow.uiColor
        )
        view.addSubview(degreeSelector)
        
        let speeches = ["Осень", "Весна", "Итог"]
        speechSelector = SelectorView(
            frame: CGRect(x: view.frame.midX - 150, y: degreeSelector.frame.maxY + 20, width: 300, height: 40),
            buttonsTitles: speeches,
            delegate: self,
            width: 100,
            color: Colors.yellow.uiColor
        )
        view.addSubview(speechSelector)
    }
    
    private func setupTableView() {
        studentsTableView.register(EstimationCell.self, forCellReuseIdentifier: "EstimationCell")
        studentsTableView.delegate = self
        studentsTableView.dataSource = self
        
        studentsView = TableView(
            contentView: view,
            frame: view.frame,
            title: "",
            tableView: studentsTableView,
            margin: 0
        )
        
        studentsView.backgroundColor = .white
        studentsTableView.layer.borderColor = UIColor.clear.cgColor
        studentsTableView.layer.cornerRadius = 0
        studentsTableView.isScrollEnabled = true
        
        view.addSubview(studentsView)
        studentsView.addSubview(studentsTableView)
        studentsView.translatesAutoresizingMaskIntoConstraints = false
        studentsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            studentsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            studentsView.heightAnchor.constraint(equalTo: studentsTableView.heightAnchor, constant: 30),
            studentsView.bottomAnchor.constraint(equalTo: studentsTableView.bottomAnchor, constant: 15),
            studentsView.topAnchor.constraint(equalTo: speechSelector.bottomAnchor, constant: 0)
        ])
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
}

extension DiplomaEstimatingViewController: DiplomaEstimatingViewInput {
    func setupStudents(students: [EstimationModel]) {
        self.students = students
        studentsTableView.reloadData()
    }
}

extension DiplomaEstimatingViewController: SelectorDelegate {
    func select(at index: Int, sender: SelectorView) {
        if sender == degreeSelector {
            output.selectDegree(bachelor: index == 0)
        } else {
            switch index {
            case 0:
                output.selectGrade(type: .autumn)
            case 1:
                output.selectGrade(type: .spring)
            case 2:
                output.selectGrade(type: .final)
            default:
                break
            }
        }
    }
}

extension DiplomaEstimatingViewController: EstimationDelegate {
    func estimate(studentID: Int, gradeID: Int, grade: Int) {
        output.estimate(studentID: studentID, gradeID: gradeID, grade: grade)
    }
}

extension DiplomaEstimatingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EstimationCell", for: indexPath) as? EstimationCell else {
            fatalError("Cannot create EstimationCell")
        }
        cell.configure(with: students[indexPath.row])
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
