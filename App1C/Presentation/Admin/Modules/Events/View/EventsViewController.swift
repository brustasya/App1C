//
//  EventsViewController.swift
//  App1C
//
//  Created by Станислава on 02.04.2024.
//

import UIKit

class EventsViewController: UIViewController {
    
    private lazy var events: [EventModel] = [
        EventModel(title: "Выбор курсов", deadline: Date(), type: .preliminaryCourseChoice),
        EventModel(title: "Выбор минимальной нагрузки", deadline: Date(), type: .finalCourseChoice),
        EventModel(title: "Выбор темы диплома", deadline: Date(), type: .diplomaSpeech)
    ]
    private lazy var eventsTableView = UITableView()
    private lazy var eventsBackgroundView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupEventsTableView()
        setupCreateEvent()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        
        NSLayoutConstraint.activate([
            eventsTableView.heightAnchor.constraint(equalToConstant: CGFloat(Double(events.count * 70) - 0.5)),
            eventsBackgroundView.heightAnchor.constraint(equalTo: eventsTableView.heightAnchor, constant: 60),
            eventsBackgroundView.bottomAnchor.constraint(equalTo: eventsTableView.bottomAnchor, constant: 15),
            eventsBackgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25)
        ])
    }
    
    private func setupCreateEvent() {
        let title = UILabel(frame: CGRect(x: Int(view.frame.midX) - 100, y: events.count * 70 + 120, width: 200, height: 20))
        title.text = "Создать событие"
        title.textColor = .black
        title.textAlignment = .center
        title.font = .systemFont(ofSize: 20, weight: .semibold)
        view.addSubview(title)
//        title.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            title.topAnchor.constraint(equalTo: eventsBackgroundView.bottomAnchor, constant: 20),
//            title.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50)
//        ])
        
        let courseSelectionButton = ButtonView(frame: CGRect(x: 25, y: title.frame.maxY + 15, width: view.frame.width - 50, height: 45))
        courseSelectionButton.setTitle("Выбор курсов", for: .normal)
        view.addSubview(courseSelectionButton)
        
        let finalCourseSelectionButton = ButtonView(frame: CGRect(x: 25, y: courseSelectionButton.frame.maxY + 10, width: view.frame.width - 50, height: 45))
        finalCourseSelectionButton.setTitle("Выбор минимальной нагрузки", for: .normal)
        view.addSubview(finalCourseSelectionButton)
        
        let estimationButton = ButtonView(frame: CGRect(x: 25, y: finalCourseSelectionButton.frame.maxY + 10, width: view.frame.width - 50, height: 45))
        estimationButton.setTitle("Выставление оценок", for: .normal)
        view.addSubview(estimationButton)
        
    }
    
    @objc private func createEventButtonTapped() {

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
//        cell.setButtonVisible(visible: false)
//        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let selectedItem = dataSource.itemIdentifier(for: indexPath) {
//            print("Selected item: \(selectedItem)")
//            output.tripDidSelect(model: selectedItem)
//        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70
        
    }
}
