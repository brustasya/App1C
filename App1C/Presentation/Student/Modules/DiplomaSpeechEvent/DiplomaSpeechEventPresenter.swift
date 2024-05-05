//
//  DiplomaSpeechEventPresenter.swift
//  App1C
//
//  Created by Станислава on 06.05.2024.
//

import Foundation

class DiplomaSpeechEventPresenter {
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
        eventsService.eventDetails(eventID: id) { [weak self] result in
            switch result {
            case .success(let model):
                let eventModel = DiplomaSpeechEventModel(
                    type: self?.getSpeechType(type: model.type) ?? .rw1,
                    deadline: Date.toDate(dateString: model.deadline),
                    timetableURL: model.timetableLink,
                    conferenceURL: model.zoomLink,
                    description: model.description
                )
                    
                DispatchQueue.main.async {
                    self?.viewInput?.updateData(model: eventModel, isEdit: true)
                    self?.viewInput?.setTitle(title: model.title)
                }
            case .failure(let error):
                Logger.shared.printLog(log: "Failed load event: \(error)")
            }
        }
    }
    
    private func getSpeechType(type: String) -> SpeechType {
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
}

extension DiplomaSpeechEventPresenter: DiplomaSpeechEventViewOutput {
    func createButtonTapped(model: DiplomaSpeechEventModel) { }
    
    func saveButtonTapped(model: DiplomaSpeechEventModel) { }
    
    func viewIsReady() {
        viewInput?.setupSaveMode()
        getEvent()
    }
}
