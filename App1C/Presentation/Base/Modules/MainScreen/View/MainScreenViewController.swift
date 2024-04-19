//
//  MainScreenViewController.swift
//  App1C
//
//  Created by Станислава on 02.04.2024.
//

import UIKit

class MainScreenViewController: UIViewController {
    
    lazy var telegramView = UIView()
    lazy var chatbotView = UIView()
    lazy var siteView = UIView()
    lazy var baseView = UIView()
    
    lazy var events: [EventModel] = [
        EventModel(id: 0, title: "Выбор курсов", deadline: Date(), type: .preliminaryCourseChoice),
        EventModel(id: 0, title: "Выбор минимальной нагрузки", deadline: Date(), type: .finalCourseChoice),
        EventModel(id: 0, title: "Выбор темы диплома", deadline: Date(), type: .diplomaSpeech)
    ]
    lazy var eventsTableView = UITableView()
    lazy var eventsBackgroundView = UIView()
    
    lazy var baseTableView = UITableView()
    lazy var baseElements: [BaseModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupLinksViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        (navigationController as? CustomNavigationController)?.hideBackButton()
        tabBarController?.tabBar.isTranslucent = true
        tabBarController?.tabBar.isHidden = false
    }
    
    func setupLinksViews() {
        telegramView = LinkView(
            contentView: view,
            frame: view.frame,
            title: "Чат кафедры",
            image: Images.telegram.uiImage,
            imageSize: CGSize(width: 50, height: 50)
        )
        chatbotView = LinkView(
            contentView: view,
            frame: view.frame,
            title: "Телеграм-бот",
            image: Images.chatbot.uiImage,
            imageSize: CGSize(width: 70, height: 70)
        )
        siteView = LinkView(
            contentView: view,
            frame: view.frame,
            title: "Сайт",
            image: Images.logo.uiImage,
            imageSize: CGSize(width: 80, height: 50)
        )
        
        view.addSubview(telegramView)
        view.addSubview(chatbotView)
        view.addSubview(siteView)
        telegramView.translatesAutoresizingMaskIntoConstraints = false
        chatbotView.translatesAutoresizingMaskIntoConstraints = false
        siteView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            chatbotView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            telegramView.trailingAnchor.constraint(equalTo: chatbotView.leadingAnchor, constant: -20),
            siteView.leadingAnchor.constraint(equalTo: chatbotView.trailingAnchor, constant: 20)
        ])
    }
    
    func setupBaseView() {
        baseTableView.register(LargeBaseCell.self, forCellReuseIdentifier: "BaseCell")
        baseTableView.delegate = self
        baseTableView.dataSource = self
        
        baseView = TableView(
            contentView: view,
            frame: view.frame,
            title: "",
            tableView: baseTableView
        )
        baseView.backgroundColor = .systemGray6
       
        view.addSubview(baseView)
        baseView.addSubview(baseTableView)
        baseView.translatesAutoresizingMaskIntoConstraints = false
        baseTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            baseTableView.heightAnchor.constraint(equalToConstant: CGFloat(59.5)),
            baseView.heightAnchor.constraint(equalTo: baseTableView.heightAnchor, constant: 30),
            baseView.bottomAnchor.constraint(equalTo: baseTableView.bottomAnchor, constant: 15)
        ])
    }
    
    func setupEventsTableView() {
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
            eventsBackgroundView.bottomAnchor.constraint(equalTo: eventsTableView.bottomAnchor, constant: 15)
        ])
    }
}

extension MainScreenViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == eventsTableView {
            return events.count
        } else {
            return baseElements.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == eventsTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as? EventCell else {
                fatalError("Cannot create EventCell")
            }
            cell.configure(with: events[indexPath.row])
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "BaseCell", for: indexPath) as? LargeBaseCell else {
                fatalError("Cannot create BaseCell")
            }
            cell.configure(with: baseElements[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == eventsTableView {
            return 70
        } else {
            return 60
        }
    }
}

