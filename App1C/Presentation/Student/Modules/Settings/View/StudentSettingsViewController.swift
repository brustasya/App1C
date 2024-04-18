//
//  StudentSettingsViewController.swift
//  App1C
//
//  Created by Станислава on 05.04.2024.
//

import UIKit

class StudentSettingsViewController: SettingsViewController {
    
    private var output: StudentSettingsViewOutput
    
    init(output: StudentSettingsViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBaseElements()
    }
    
    override func setupBaseElements() {
        baseElements.insert(
            BaseModel(title: "Курсы кафедры", image: Images.books.uiImage),
            at: 2
        )
        super.setupBaseElements()
    }
}

extension StudentSettingsViewController: StudentSettingsViewInput {
    
}

extension StudentSettingsViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.selectRowAt(index: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
