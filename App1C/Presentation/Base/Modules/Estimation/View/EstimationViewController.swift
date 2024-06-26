//
//  EstimationViewController.swift
//  App1C
//
//  Created by Станислава on 14.04.2024.
//

import UIKit

class EstimationViewController: UIViewController {
    
    private lazy var titleLabel = UILabel()
    private lazy var personsView = UIView()
    private lazy var personTableView = UITableView()
    private lazy var finishEstimatingButton = UIButton()
    private lazy var persons: [EstimationModel] = []
    
    private var output: EstimationViewOutput

    init(output: EstimationViewOutput) {
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
        titleLabel = TitleView(frame: CGRect(x: 30, y: 25, width: view.frame.width - 60, height: 60), title: "Тестирование программного обеспечения")
        view.addSubview(titleLabel)
    }
    
    private func setupTableView() {
        personTableView.register(EstimationCell.self, forCellReuseIdentifier: "EstimationCell")
        personTableView.delegate = self
        personTableView.dataSource = self
        
        personsView = TableView(
            contentView: view,
            frame: view.frame,
            title: "Оценки",
            tableView: personTableView,
            margin: 0
        )
        
        personsView.backgroundColor = .white
        personTableView.layer.borderColor = UIColor.clear.cgColor
        personTableView.isScrollEnabled = true
        
        view.addSubview(personsView)
        personsView.addSubview(personTableView)
        personsView.translatesAutoresizingMaskIntoConstraints = false
        personTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
           // personTableView.heightAnchor.constraint(equalToConstant: CGFloat(Double(persons.count * 60) - 0.5)),
            personTableView.bottomAnchor.constraint(equalTo: finishEstimatingButton.topAnchor, constant: -20),
            personsView.heightAnchor.constraint(equalTo: personTableView.heightAnchor, constant: 60),
            personsView.bottomAnchor.constraint(equalTo: personTableView.bottomAnchor, constant: 15),
            personsView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10)
        ])
    }
    
    private func setupFinishEstimatingButton() {
        let y = tabBarController?.tabBar.frame.minY ?? view.frame.maxY
        finishEstimatingButton = ButtonView(frame: CGRect(x: 25, y: y - 100, width: view.frame.width - 50, height: 45))
        view.addSubview(finishEstimatingButton)
        finishEstimatingButton.setTitle("Завершить выставление оценок", for: .normal)
        finishEstimatingButton.addTarget(self, action: #selector(finishEstimation), for: .touchUpInside)
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func finishEstimation() {
        output.finishEstimating()
    }
}

extension EstimationViewController: EstimationViewInput {
    func setupGrades(grades: [EstimationModel]) {
        persons = grades
        setupTableView()
    }
    
    func setTitle(title: String) {
        titleLabel.text = title
    }
    
    func close() {
        goBack()
    }
}


extension EstimationViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EstimationCell", for: indexPath) as? EstimationCell else {
            fatalError("Cannot create EstimationCell")
        }
        cell.configure(with: persons[indexPath.row])
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

protocol EstimationDelegate: AnyObject {
    func estimate(studentID: Int, gradeID: Int, grade: Int)
}

extension EstimationViewController: EstimationDelegate {
    func estimate(studentID: Int, gradeID: Int, grade: Int) {
        output.estimate(id: studentID, grade: grade)
    }
}
