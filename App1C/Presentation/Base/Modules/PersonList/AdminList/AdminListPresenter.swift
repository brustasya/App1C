//
//  AdminListPresenter.swift
//  App1C
//
//  Created by Станислава on 09.04.2024.
//

import Foundation

class AdminListPresenter {
    weak var viewInput: PersonListViewInput?
    weak var moduleOutput: AdminListModuleOutput?
    
    private var admins: [BaseModel] = [
        BaseModel(id: 0, title: "Грушина Наталья Игоревна", image: Images.largePerson.uiImage),
        BaseModel(id: 1, title: "Ляхов Андрей Викторович", image: Images.largePerson.uiImage),
        BaseModel(id: 2, title: "Гвоздева Анна Андреевна", image: Images.largePerson.uiImage),
    ]
    
    private let usersListService: UsersListServiceProtocol
    
    init(
        moduleOutput: AdminListModuleOutput,
        usersListService: UsersListServiceProtocol
    ) {
        self.moduleOutput = moduleOutput
        self.usersListService = usersListService
    }
    
    private func getAdmins() {
        usersListService.getAdmins() { [weak self] result in
            switch result {
            case .success(let model):
                let admins = model.users.map({
                    BaseModel(id: $0.id, title: $0.fullName ?? "", image: Images.largePerson.uiImage)
                })
                self?.admins = admins
                DispatchQueue.main.async {
                    self?.viewInput?.setupPersonTable(with: admins)
                }
            case .failure(let failure):
                Logger.shared.printLog(log: "Failed load admins: \(failure)")
            }
        }
    }
}

extension AdminListPresenter: PersonListViewOutput {
    func selectedRowAt(index: Int) {
        moduleOutput?.moduleWantsToOpenAdminDetails(id: admins[index].id)
    }
    
    func viewIsReady() {
        viewInput?.updateTitle(title: "Администраторы")
        getAdmins()
    }
    
    func goBack() {
        moduleOutput?.moduleWantsToCloseAdminList()
    }
    
    func addButtonTapped() { }
}
