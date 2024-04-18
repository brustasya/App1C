//
//  AdminListPresenter.swift
//  App1C
//
//  Created by Станислава on 09.04.2024.
//

import Foundation

final class AdminListPresenter {
    weak var viewInput: PersonListViewInput?
    weak var moduleOutput: AdminListModuleOutput?
    
    private let admins: [BaseModel] = [
        BaseModel(title: "Грушина Наталья Игоревна", image: Images.largePerson.uiImage),
        BaseModel(title: "Ляхов Андрей Викторович", image: Images.largePerson.uiImage),
        BaseModel(title: "Гвоздева Анна Андреевна", image: Images.largePerson.uiImage),
    ]
    
//    private let telemetryService: TelemetryServiceProtocol
    
    init(
        moduleOutput: AdminListModuleOutput
//        telemetryService: TelemetryServiceProtocol
    ) {
        self.moduleOutput = moduleOutput
//        self.telemetryService = telemetryService
    }
}

extension AdminListPresenter: PersonListViewOutput {
    func selectedRowAt(index: Int) {
        
    }
    
    func viewIsReady() {
        viewInput?.updateTitle(title: "Администраторы")
        viewInput?.setupPersonTable(with: admins)
    }
}
