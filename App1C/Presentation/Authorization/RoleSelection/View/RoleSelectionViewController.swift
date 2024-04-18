//
//  RoleSelectionViewController.swift
//  App1C
//
//  Created by Станислава on 02.04.2024.
//

import UIKit

class RoleSelectionViewController: UIViewController {
    
    private var output: RoleSelectionViewOutput
    
    private lazy var rolesView = UIView()
    lazy var rolesTableView = UITableView()
    lazy var roles: [BaseModel] = []
    
//    private lazy var studentRoleButton = ButtonView(contentView: view, frame: view.frame)
//    private lazy var teacherRoleButton = ButtonView(contentView: view, frame: view.frame)
//    private lazy var adminRoleButton = ButtonView(contentView: view, frame: view.frame)
    
    init(output: RoleSelectionViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white//Colors.paleYellow.uiColor
        
        output.viewIsReady()
    }
    
    func setupRolesView() {
        rolesTableView.register(LargeBaseCell.self, forCellReuseIdentifier: "BaseCell")
        rolesTableView.delegate = self
        rolesTableView.dataSource = self
        
        rolesView = TableView(
            contentView: view,
            frame: view.frame,
            title: "",
            tableView: rolesTableView
        )
        rolesView.backgroundColor = Colors.yellow.uiColor
        rolesTableView.layer.borderColor = UIColor.clear.cgColor
        
        view.addSubview(rolesView)
        rolesView.addSubview(rolesTableView)
        rolesView.translatesAutoresizingMaskIntoConstraints = false
        rolesTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rolesTableView.heightAnchor.constraint(equalToConstant: CGFloat(roles.count * 60) - 0.5),
            rolesView.heightAnchor.constraint(equalTo: rolesTableView.heightAnchor, constant: 30),
            rolesView.bottomAnchor.constraint(equalTo: rolesTableView.bottomAnchor, constant: 15),
            rolesView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -130)
        ])
    }
    
    private func setupImage() {
        let imageView = UIImageView(image: Images.biglogo.uiImage)
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 30),
            imageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}

extension RoleSelectionViewController: RoleSelectionViewInput {
    func showRoles(roles: [BaseModel]) {
        self.roles = roles
        setupRolesView()
        setupImage()
    }
}

extension RoleSelectionViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BaseCell", for: indexPath) as? LargeBaseCell else {
            fatalError("Cannot create BaseCell")
        }
        cell.configure(with: roles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.selectedRowAt(index: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}


