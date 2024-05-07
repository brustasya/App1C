//
//  DiplomaSpeechesResultsViewController.swift
//  App1C
//
//  Created by Станислава on 07.05.2024.
//

import UIKit

final class DiplomaSpeechesResultsViewController: UIViewController {
    
    private lazy var titleLabel = UILabel()
    private lazy var addStudentButton = UIButton()
    private lazy var degreeSelector = UIView()//SelectorView(frame: .zero, buttonsTitles: [], delegate: nil)
    private lazy var speechSelector = UIView()//SelectorView(frame: .zero, buttonsTitles: [], delegate: nil)
    private lazy var studentsView = UIView()
    private lazy var studentsTableView = UITableView()
    private lazy var students: [SpeechResultModel] = []
    
    private var output: DiplomaSpeechesResultsViewOutput

    init(output: DiplomaSpeechesResultsViewOutput) {
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
        
        let speeches = ["НИР 1", "НИР 2", "НИР 3", "Предзащита",]
        speechSelector = SelectorView(
            frame: CGRect(x: view.frame.midX - 175, y: degreeSelector.frame.maxY + 20, width: 350, height: 40),
            buttonsTitles: speeches,
            delegate: self,
            width: 80,
            color: Colors.yellow.uiColor,
            fontSize: 12
        )
        view.addSubview(speechSelector)
    }
    
    private func setupTableView() {
        studentsTableView.register(SpeechResultCell.self, forCellReuseIdentifier: "SpeechResultCell")
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
        studentsTableView.separatorColor = .clear
        
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

extension DiplomaSpeechesResultsViewController: DiplomaSpeechesResultsViewInput {
    func setupStudents(students: [SpeechResultModel]) {
        self.students = students
        studentsTableView.reloadData()
    }
}

extension DiplomaSpeechesResultsViewController: SelectorDelegate {
    func select(at index: Int, sender: SelectorView) {
        if sender == degreeSelector {
            output.selectDegree(bachelor: index == 0)
        } else {
            switch index {
            case 0:
                output.selectSpeech(type: .rw1)
            case 1:
                output.selectSpeech(type: .rw2)
            case 2:
                output.selectSpeech(type: .rw3)
            case 3:
                output.selectSpeech(type: .predefending)
            default:
                break
            }
        }
    }
}

extension DiplomaSpeechesResultsViewController: SpeechSelectorDelegate {
    func select(studentID: Int, speechID: Int) {
        output.addResult(studentID: studentID, speechID: speechID, result: true)
    }
    
    func unSelect(studentID: Int, speechID: Int) {
        output.addResult(studentID: studentID, speechID: speechID, result: false)
    }
}

extension DiplomaSpeechesResultsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SpeechResultCell", for: indexPath) as? SpeechResultCell else {
            fatalError("Cannot create SpeechResultCell")
        }
        cell.configure(with: students[indexPath.row])
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
}


