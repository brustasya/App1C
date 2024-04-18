//
//  StudentMainScreenController.swift
//  App1C
//
//  Created by Станислава on 04.04.2024.
//

import UIKit

class StudentMainScreenController: MainScreenViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
            
        setupSheduleView()
        setupEventsTableView()
        (navigationController as? CustomNavigationController)?.setupBellButton()
    }
    
    private func setupSheduleView() {
        baseElements.append(BaseModel(id: 0, title: "Расписание", image: Images.shedule.uiImage))
        super.setupBaseView()
        
        NSLayoutConstraint.activate([
            baseView.topAnchor.constraint(equalTo: telegramView.bottomAnchor, constant: 20),
        ])
    }
    
    override func setupEventsTableView() {
        super.setupEventsTableView()
        
        NSLayoutConstraint.activate([
            eventsBackgroundView.topAnchor.constraint(equalTo: baseView.bottomAnchor, constant: 20),
        ])
    }
}

extension StudentMainScreenController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == baseTableView {
            navigationController?.pushViewController(TimeTableViewController(), animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

