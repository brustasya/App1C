//
//  TeacherMainScreenController.swift
//  App1C
//
//  Created by Станислава on 04.04.2024.
//

import UIKit

class TeacherMainScreenController: MainScreenViewController {

    private var output: TeacherMainScreenViewOutput
        
    init(output: TeacherMainScreenViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        output.viewIsReady()
        //(navigationController as? CustomNavigationController)?.setupBellButton()
    }
    
    override func setupLinksViews() {
        super.setupLinksViews()
    
        let openTelegramGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openTelegram))
        let openChatbotGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openChatbot))
        let openSiteGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openSite))
        
        telegramView.isUserInteractionEnabled = true
        chatbotView.isUserInteractionEnabled = true
        siteView.isUserInteractionEnabled = true
        
        telegramView.addGestureRecognizer(openTelegramGestureRecognizer)
        chatbotView.addGestureRecognizer(openChatbotGestureRecognizer)
        siteView.addGestureRecognizer(openSiteGestureRecognizer)
    }
    
    override func setupEventsTableView() {
        super.setupEventsTableView()
        
        NSLayoutConstraint.activate([
            eventsBackgroundView.topAnchor.constraint(equalTo: telegramView.bottomAnchor, constant: 20)
        ])
    }
    
    @objc private func openTelegram() {
        output.openTelegram()
    }
    
    @objc private func openChatbot() {
        output.openChatbot()
    }
    
    @objc private func openSite() {
        output.openSite()
    }
}

extension TeacherMainScreenController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.selectEvent(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension TeacherMainScreenController: TeacherMainScreenViewInput {
    func updateEvents(events: [EventModel]) {
        self.events = events
        setupEventsTableView()
    }
}

