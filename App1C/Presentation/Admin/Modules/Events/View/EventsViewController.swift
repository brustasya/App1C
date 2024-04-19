//
//  EventsViewController.swift
//  App1C
//
//  Created by Станислава on 02.04.2024.
//

import UIKit

class EventsViewController: UIViewController {
    
    private lazy var events: [EventModel] = [
        EventModel(id: 0, title: "Выбор курсов", deadline: Date(), type: .preliminaryCourseChoice),
        EventModel(id: 0, title: "Выбор минимальной нагрузки", deadline: Date(), type: .finalCourseChoice),
        EventModel(id: 0, title: "Выбор темы диплома", deadline: Date(), type: .diplomaSpeech)
    ]
    private lazy var eventsTableView = UITableView()
    private lazy var eventsBackgroundView = UIView()
    private lazy var courseAggregationButton = UIButton()

    private var output: EventsViewOutput
        
    init(output: EventsViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupEventsTableView()
        setupCreateEvent()
        output.viewIsReady()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        (navigationController as? CustomNavigationController)?.hideBackButton()

        tabBarController?.tabBar.isTranslucent = true
        tabBarController?.tabBar.isHidden = false
    }
    
    private func setupEventsTableView() {
        eventsTableView.register(EventCell.self, forCellReuseIdentifier: "EventCell")
        eventsTableView.delegate = self
        eventsTableView.dataSource = self
        
        eventsBackgroundView = TableView(
            contentView: view,
            frame: view.frame,
            title: "Текущие события",
            tableView: eventsTableView
        )
        
        view.addSubview(eventsBackgroundView)
        eventsBackgroundView.addSubview(eventsTableView)
        eventsBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        eventsTableView.translatesAutoresizingMaskIntoConstraints = false
        eventsTableView.isScrollEnabled = true
        
        NSLayoutConstraint.activate([
            eventsTableView.heightAnchor.constraint(equalToConstant: 245),
            eventsBackgroundView.heightAnchor.constraint(equalTo: eventsTableView.heightAnchor, constant: 60),
            eventsBackgroundView.bottomAnchor.constraint(equalTo: eventsTableView.bottomAnchor, constant: 15),
            eventsBackgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25)
        ])
    }
    
    private func setupCreateEvent() {
        let title = UILabel(frame: CGRect(x: Int(view.frame.midX) - 100, y: 380, width: 200, height: 20))
        title.text = "Создать событие"
        title.textColor = .black
        title.textAlignment = .center
        title.font = .systemFont(ofSize: 20, weight: .semibold)
        view.addSubview(title)
        
        let courseSelectionButton = ButtonView(frame: CGRect(x: 25, y: title.frame.maxY + 15, width: view.frame.width - 50, height: 45))
        courseSelectionButton.setTitle("Выбор курсов", for: .normal)
        view.addSubview(courseSelectionButton)
        courseSelectionButton.addTarget(self, action: #selector(createPreliminaryChoiceEventButtonTapped), for: .touchUpInside)
        
        let finalCourseSelectionButton = ButtonView(frame: CGRect(x: 25, y: courseSelectionButton.frame.maxY + 10, width: view.frame.width - 50, height: 45))
        finalCourseSelectionButton.setTitle("Выбор минимальной нагрузки", for: .normal)
        view.addSubview(finalCourseSelectionButton)
        finalCourseSelectionButton.addTarget(self, action: #selector(createFinalChoiceEventButtonTapped), for: .touchUpInside)
        
        let estimationButton = ButtonView(frame: CGRect(x: 25, y: finalCourseSelectionButton.frame.maxY + 10, width: view.frame.width - 50, height: 45))
        estimationButton.setTitle("Выставление оценок", for: .normal)
        view.addSubview(estimationButton)
        estimationButton.addTarget(self, action: #selector(createEstimatingEventButtonTapped), for: .touchUpInside)
    }
    
    @objc private func createPreliminaryChoiceEventButtonTapped() {
        output.createPreliminaryChoice()
    }
    
    @objc private func createFinalChoiceEventButtonTapped() {
        output.createFinalChoice()
    }
    
    @objc private func createEstimatingEventButtonTapped() {
        output.createEstimating()
    }
}

extension EventsViewController: EventsViewInput {
    func updateEvents(events: [EventModel]) {
        self.events = events
        eventsTableView.reloadData()
    }
}

extension EventsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as? EventCell else {
            fatalError("Cannot create EventCell")
        }
        cell.configure(with: events[indexPath.row])

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.selectRow(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70
        
    }
}
