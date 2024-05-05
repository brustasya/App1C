//
//  NotificationsViewController.swift
//  App1C
//
//  Created by Станислава on 03.05.2024.
//

import UIKit

class NotificationsViewController: UIViewController {
    
    private lazy var notificationsView = UIView()
    private lazy var notificationsTableView = UITableView()
    private lazy var notifications: [NotificationModel] = []
    
    private var output: NotificationsViewOutput
    
    init(output: NotificationsViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupTableView()
        output.viewIsReady()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true
        (navigationController as? CustomNavigationController)?.setupBackButton()
        (navigationController as? CustomNavigationController)?.backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        (navigationController as? CustomNavigationController)?.bellButton.isHidden = true
        
        tabBarController?.tabBar.isTranslucent = true
        tabBarController?.tabBar.isHidden = true
        output.viewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        (navigationController as? CustomNavigationController)?.hideBackButton()
    }

    private func setupTableView() {
        notificationsTableView.register(NotificationCell.self, forCellReuseIdentifier: "NotificationCell")
        notificationsTableView.delegate = self
        notificationsTableView.dataSource = self
        
//        notificationsView = TableView(
//            contentView: view,
//            frame: view.frame,
//            title: "",
//            tableView: notificationsTableView,
//            margin: 0
//        )
        
      //  notificationsView.backgroundColor = .white
        notificationsTableView.layer.borderColor = UIColor.clear.cgColor
        notificationsTableView.layer.cornerRadius = 0
        notificationsTableView.isScrollEnabled = true
        notificationsTableView.separatorColor = .clear
        
      //  view.addSubview(notificationsView)
        view.addSubview(notificationsTableView)
        notificationsView.translatesAutoresizingMaskIntoConstraints = false
        notificationsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            notificationsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            notificationsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            notificationsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            notificationsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
//            notificationsTableView.heightAnchor.constraint(equalToConstant: CGFloat(Double(notifications.count * 50) - 0.5)),
//            notificationsView.heightAnchor.constraint(equalTo: notificationsTableView.heightAnchor, constant: 30),
//            notificationsView.bottomAnchor.constraint(equalTo: notificationsTableView.bottomAnchor, constant: 15),
            //notificationsView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10)
        ])
    }
    
    @objc private func goBack() {
        navigationController?.popViewController(animated: true)
    }
}

extension NotificationsViewController: NotificationsViewInput {
    func setupEvents(with notifications: [NotificationModel]) {
        self.notifications = notifications
        notificationsTableView.reloadData()
    }
}

extension NotificationsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as? NotificationCell else {
            fatalError("Cannot create NotificationCell")
        }
        cell.configure(with: notifications[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.selectedRowAt(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}




