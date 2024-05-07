//
//  ModifyDiplomaSpeechEventPresenter.swift
//  App1C
//
//  Created by Станислава on 05.05.2024.
//

import Foundation

class ModifyDiplomaSpeechEventPresenter {
    weak var viewInput: DiplomaSpeechEventViewInput?
    
    private let eventsService: EventsServiceProtocol
    private let id: Int
    
    init(
        id: Int,
        eventsService: EventsServiceProtocol
    ) {
        self.id = id
        self.eventsService = eventsService
    }
    
    private func getEvent() {
        eventsService.getModifyEvent(eventID: id) { [weak self] result in
            switch result {
            case .success(let model):
                let eventModel = DiplomaSpeechEventModel(
                    type: self?.getSpeechType(type: model.speechType) ?? .rw1,
                    deadline: Date.toDate(dateString: model.deadline),
                    timetableURL: model.timetableLink,
                    conferenceURL: model.zoomLink,
                    description: model.description
                )
                    
                DispatchQueue.main.async {
                    self?.viewInput?.updateData(model: eventModel, isEdit: true)
                }
            case .failure(let error):
                Logger.shared.printLog(log: "Failed load event: \(error)")
            }
        }
    }
    
    private func getSpeechType(type: String?) -> SpeechType {
        switch type {
        case SpeechType.rw1.rawValue:
            return .rw1
        case SpeechType.rw2.rawValue:
            return .rw2
        case SpeechType.rw3.rawValue:
            return .rw3
        case SpeechType.defending.rawValue:
            return .defending
        case SpeechType.predefending.rawValue:
            return .predefending
        default:
            return .rw1
        }
    }
    
    private func modifyEvent(model: EventDetailServiceModel) {
        eventsService.modifyEvent(eventID: id, eventModel: model) { [weak self] result in
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

extension ModifyDiplomaSpeechEventPresenter: DiplomaSpeechEventViewOutput {
    func createButtonTapped(model: DiplomaSpeechEventModel) { }
    
    func saveButtonTapped(model: DiplomaSpeechEventModel) {
        let modifyEventModel = EventDetailServiceModel(
            id: id,
            title: EventType.diplomaThemeChoice.title,
            description: model.description,
            deadline: Date.toString(date: model.deadline),
            type: EventType.diplomaSpeech.rawValue,
            speechType: model.type.rawValue,
            timetableLink: model.timetableURL,
            zoomLink: model.conferenceURL,
            ownDiplomaDeadline: nil,
            universityDiplomaDeadline: nil,
            workDiplomaDeadline: nil,
            themes: nil
        )
        modifyEvent(model: modifyEventModel)
    }
    
    func viewIsReady() {
        viewInput?.setupSaveMode()
        getEvent()
    }
}
