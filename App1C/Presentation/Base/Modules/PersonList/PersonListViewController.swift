//
//  PersonListViewController.swift
//  App1C
//
//  Created by Станислава on 09.04.2024.
//

import UIKit

class PersonListViewController: UIViewController {
    
    private lazy var titleLabel = UILabel()
    private lazy var personsView = UIView()
    private lazy var personTableView = UITableView()
    private lazy var persons: [BaseModel] = []
    
    private var output: PersonListViewOutput
    
    init(output: PersonListViewOutput) {
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
        output.viewIsReady()
    }
    
    private func setupTitle() {
        titleLabel = TitleView(frame: CGRect(x: 30, y: 25, width: view.frame.width, height: 30), title: "")
        view.addSubview(titleLabel)
    }
    
    private func setupTableView() {
        personTableView.register(BaseCell.self, forCellReuseIdentifier: "BaseCell")
        personTableView.delegate = self
        personTableView.dataSource = self
        
        personsView = TableView(
            contentView: view,
            frame: view.frame,
            title: "",
            tableView: personTableView
        )
        
        view.addSubview(personsView)
        personsView.addSubview(personTableView)
        personsView.translatesAutoresizingMaskIntoConstraints = false
        personTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            personTableView.heightAnchor.constraint(equalToConstant: CGFloat(Double(persons.count * 50) - 0.5)),
            personsView.heightAnchor.constraint(equalTo: personTableView.heightAnchor, constant: 30),
            personsView.bottomAnchor.constraint(equalTo: personTableView.bottomAnchor, constant: 15),
            personsView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20)
        ])
    }
}

extension PersonListViewController: PersonListViewInput {
    func setupPersonTable(with persons: [BaseModel]) {
        self.persons = persons
        setupTableView()
    }
    
    func updateTitle(title: String) {
        titleLabel.text = title
    }
}

extension PersonListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BaseCell", for: indexPath) as? BaseCell else {
            fatalError("Cannot create BaseCell")
        }
        cell.configure(with: persons[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.selectedRowAt(index: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}



