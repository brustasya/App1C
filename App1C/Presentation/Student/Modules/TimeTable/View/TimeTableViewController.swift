//
//  TimeTableViewController.swift
//  App1C
//
//  Created by Станислава on 08.04.2024.
//

import UIKit

class TimeTableViewController: UIViewController {
    
    private lazy var timeTable: [TimetableModel] = [
//        TimetableModel(time: "9:00 - 10:25", titles: ["Программирование"]),
//        TimetableModel(time: "10:45 - 12:10", titles: ["Программирование", "Тестирование"]),
//        TimetableModel(time: "12:20 - 13:45", titles: ["Разработка программного обеспечения. Java"]),
//        TimetableModel(time: "14:00 - 15:25", titles: []),
    ]
    
    private lazy var timeTableView = UITableView()
    private lazy var separatorView = UIView()
    private lazy var weekDaySelector = UIView()
    
    private var output: TimeTableViewOutput

    init(output: TimeTableViewOutput) {
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
        setupTimeTableView()
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
        let titleLabel = TitleView(frame: CGRect(x: 30, y: 25, width: view.frame.width, height: 30), title: "Расписание")
        view.addSubview(titleLabel)

        let daysOfWeek = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб"]
        weekDaySelector = SelectorView(
            frame: CGRect(x: view.frame.midX - 150, y: 70, width: 300, height: 50),
            buttonsTitles: daysOfWeek,
            delegate: self
        )
        view.addSubview(weekDaySelector)
    }

    private func setupTimeTableView() {
        timeTableView.register(TimetableCell.self, forCellReuseIdentifier: "TimetableCell")
        timeTableView.delegate = self
        timeTableView.dataSource = self
        timeTableView.separatorColor = .clear
        timeTableView.isScrollEnabled = false
        
        view.addSubview(timeTableView)
        timeTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(separatorView)
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        
        separatorView.backgroundColor = Colors.yellow.uiColor
        
        NSLayoutConstraint.activate([
            timeTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            timeTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            timeTableView.topAnchor.constraint(equalTo: weekDaySelector.bottomAnchor, constant: 20),
            timeTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            
            separatorView.heightAnchor.constraint(equalToConstant: 250),
            separatorView.widthAnchor.constraint(equalToConstant: 2),
            separatorView.topAnchor.constraint(equalTo: timeTableView.topAnchor),
            separatorView.leadingAnchor.constraint(equalTo: timeTableView.centerXAnchor, constant: -51)
        ])
    }
    
    private func setupCreateEventButton() {
        let createEventButton = UIButton()
        view.addSubview(createEventButton)
        createEventButton.translatesAutoresizingMaskIntoConstraints = false
        createEventButton.setTitle("Создать событие", for: .normal)
        
        createEventButton.backgroundColor = Colors.yellow.uiColor
        createEventButton.setTitleColor(.black, for: .normal)
        createEventButton.layer.cornerRadius = 15
        
        NSLayoutConstraint.activate([
            createEventButton.heightAnchor.constraint(equalToConstant: 45),
            createEventButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            createEventButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            createEventButton.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 25)
            
        ])
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
}

extension TimeTableViewController: TimeTableViewInput {
    func updateTimeTable(with timeTable: [TimetableModel]) {
        self.timeTable = timeTable
        timeTableView.reloadData()
    }
}


extension TimeTableViewController: SelectorDelegate {
    func select(at index: Int, sender: SelectorView) {
        output.openDay(day: index + 1)
    }
}

extension TimeTableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TimetableCell", for: indexPath) as? TimetableCell else {
            fatalError("Cannot create TimetableCell")
        }
        cell.configure(with: timeTable[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


