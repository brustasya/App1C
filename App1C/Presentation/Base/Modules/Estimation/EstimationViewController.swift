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
    private lazy var persons: [EstimationModel] = [
        EstimationModel(studentID: 0, name: "Бобрускина Станислава Алексеевна", grade: GradeModel(grade: 0)),
        EstimationModel(studentID: 0, name: "Лосюков Андрей Михайлович", grade: GradeModel(grade: 10)),
        EstimationModel(studentID: 0, name: "Кузьмина Екатерина Андреевна", grade: GradeModel(grade: 7)),
        EstimationModel(studentID: 0, name: "Татьянченко Дмитрий Витальевич", grade: GradeModel(grade: 6)),
        EstimationModel(studentID: 0, name: "Сергеева Ирина Олеговна", grade: GradeModel(grade: 2)),
        EstimationModel(studentID: 0, name: "Бобрускина Станислава Алексеевна", grade: GradeModel(grade: 0)),
        EstimationModel(studentID: 0, name: "Лосюков Андрей Михайлович", grade: GradeModel(grade: 10)),
        EstimationModel(studentID: 0, name: "Кузьмина Екатерина Андреевна", grade: GradeModel(grade: 7)),
        EstimationModel(studentID: 0, name: "Татьянченко Дмитрий Витальевич", grade: GradeModel(grade: 6)),
        EstimationModel(studentID: 0, name: "Сергеева Ирина Олеговна", grade: GradeModel(grade: 2))
    ]
    
//    private var output: PersonListViewOutput
//
//    init(output: PersonListViewOutput) {
//        self.output = output
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupTitle()
        setupFinishEstimatingButton()
        setupTableView()
       // output.viewIsReady()
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
        tabBarController?.tabBar.isHidden = true
        let y = tabBarController?.tabBar.frame.minY ?? view.frame.maxY //navigationController?.tabBarController.frame.minY ?? view.frame.maxY
        finishEstimatingButton = ButtonView(frame: CGRect(x: 25, y: y - 100, width: view.frame.width - 50, height: 45))
        view.addSubview(finishEstimatingButton)
        finishEstimatingButton.setTitle("Завершить выставление оценок", for: .normal)
    }
}

//extension EstimationViewController: PersonListViewInput {
//    func setupPersonTable(with persons: [BaseModel]) {
//        self.persons = persons
//        setupTableView()
//    }
//
//    func updateTitle(title: String) {
//        titleLabel.text = title
//    }
//}

extension EstimationViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EstimationCell", for: indexPath) as? EstimationCell else {
            fatalError("Cannot create EstimationCell")
        }
        cell.configure(with: persons[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}




