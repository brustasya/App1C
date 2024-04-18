//
//  StudentsListViewController.swift
//  App1C
//
//  Created by Станислава on 18.04.2024.
//

import UIKit

final class StudentsListViewController: UIViewController {
    
    private lazy var addStudentButton = UIButton()
    
    private var output: StudentsListViewOutput

    init(output: StudentsListViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupAddStudentButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isTranslucent = true
        tabBarController?.tabBar.isHidden = true
    }
    
    private func setupAddStudentButton() {
        let y = tabBarController?.tabBar.frame.minY ?? view.frame.maxY
        addStudentButton = ButtonView(frame: CGRect(x: 25, y: y - 100, width: view.frame.width - 50, height: 45))
        view.addSubview(addStudentButton)
        addStudentButton.setTitle("Добавить студента", for: .normal)
        
        addStudentButton.addTarget(self, action: #selector(addStudent), for: .touchUpInside)
    }
    
    @objc func addStudent() {
        output.addStudent()
    }
}

extension StudentsListViewController: StudentsListViewInput {
    
}
