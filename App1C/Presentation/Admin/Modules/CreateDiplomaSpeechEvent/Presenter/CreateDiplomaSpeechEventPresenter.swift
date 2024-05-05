//
//  CreateDiplomaSpeechEventPresenter.swift
//  App1C
//
//  Created by Станислава on 05.05.2024.
//

import Foundation

class CreateDiplomaSpeechEventPresenter {
    weak var viewInput: DiplomaSpeechEventViewInput?
    
    private let eventsService: EventsServiceProtocol
    
    init(
        eventsService: EventsServiceProtocol
    ) {
        self.eventsService = eventsService
    }
    
    private func createEvent(model: CreateDiplomaSpeechModel) {
        eventsService.createDiplomaSpeechEvent(model: model) { [weak self] result in
            switch result {
            case .success(_):
                Logger.shared.printLog(log: "Success create event")
                DispatchQueue.main.async {
                  self?.viewInput?.close()
                }
            case .failure(let error):
                Logger.shared.printLog(log: "Failed create event: \(error)")
            }
        }
    }
}

extension CreateDiplomaSpeechEventPresenter: DiplomaSpeechEventViewOutput {
    func createButtonTapped(model: DiplomaSpeechEventModel) {
        let createEventModel = CreateDiplomaSpeechModel(
            title: model.type.title,
            description: model.description,
            timetableLink: model.timetableURL ?? "",
            zoomLink: model.conferenceURL,
            deadline: Date.toString(date: model.deadline),
            speechType: model.type.rawValue
        )
        createEvent(model: createEventModel)
    }
    
    func saveButtonTapped(model: DiplomaSpeechEventModel) { }
    
    func viewIsReady() {
        viewInput?.setupCreateMode()
    }
}
