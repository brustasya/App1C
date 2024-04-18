//
//  AdminSettingsViewController.swift
//  App1C
//
//  Created by Станислава on 05.04.2024.
//

import UIKit

class AdminSettingsViewController: SettingsViewController {
    
    private var output: AdminSettingsViewOutput
    
    init(output: AdminSettingsViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBaseElements()
        setupEducationElements()
    }
}

extension AdminSettingsViewController: AdminSettingsViewInput {
    
}

extension AdminSettingsViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == baseTableView {
            output.selectRowAt(index: indexPath.row)
        } else {
            output.selectEducationRowAt(index: indexPath.row)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

