//
//  StudentMainScreenController.swift
//  App1C
//
//  Created by Станислава on 04.04.2024.
//

import UIKit

class StudentMainScreenController: MainScreenViewController {

    private var output: StudentMainScreenViewOutput
    
    private lazy var courseAggregationButton = UIButton()
    
    init(output: StudentMainScreenViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        setupSheduleView()
        output.viewIsReady()
        //(navigationController as? CustomNavigationController)?.setupBellButton()
    }
    
    private func setupSheduleView() {
        baseElements.append(BaseModel(id: 0, title: "Расписание", image: Images.shedule.uiImage))
        super.setupBaseView()
        
        NSLayoutConstraint.activate([
            baseView.topAnchor.constraint(equalTo: telegramView.bottomAnchor, constant: 20),
        ])
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
            eventsBackgroundView.topAnchor.constraint(equalTo: baseView.bottomAnchor, constant: 20),
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

extension StudentMainScreenController: StudentMainScreenViewInput {
    func updateEvents(events: [EventModel]) {
        self.events = events
        setupEventsTableView()
    }
}

extension StudentMainScreenController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == baseTableView {
           // output.openTimeTable()
            navigationController?.pushViewController(TimeTableViewController(), animated: true)
        } else {
            output.selectEvent(at: indexPath.row)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

