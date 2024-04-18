//
//  TeacherMainScreenController.swift
//  App1C
//
//  Created by Станислава on 04.04.2024.
//

import UIKit

class TeacherMainScreenController: MainScreenViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
            
        setupEventsTableView()
        (navigationController as? CustomNavigationController)?.setupBellButton()
    }
    
    override func setupEventsTableView() {
        super.setupEventsTableView()
        
        NSLayoutConstraint.activate([
            eventsBackgroundView.topAnchor.constraint(equalTo: telegramView.bottomAnchor, constant: 20)
        ])
    }
}

extension TeacherMainScreenController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let selectedItem = dataSource.itemIdentifier(for: indexPath) {
//            print("Selected item: \(selectedItem)")
//            output.tripDidSelect(model: selectedItem)
//        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

