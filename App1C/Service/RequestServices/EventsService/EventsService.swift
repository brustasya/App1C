//
//  EventsService.swift
//  App1C
//
//  Created by Станислава on 16.04.2024.
//

import Foundation

protocol EventsServiceProtocol {
    func events(completion: @escaping (Result<EventsModel, Error>) -> Void)
    func eventDetails(eventID: Int, completion: @escaping (Result<EventDetailServiceModel, Error>) -> Void)
    func getModifyEvent(eventID: Int, completion: @escaping (Result<EventDetailServiceModel, Error>) -> Void)
    func modifyEvent(eventID: Int, eventModel: EventDetailServiceModel, completion: @escaping (Result<Data?, Error>) -> Void)
    func currentEvents(completion: @escaping (Result<CurrentEventsModel, Error>) -> Void)
    func watchEvent(eventID: Int, completion: @escaping (Result<Data?, Error>) -> Void)
    func createSemester(model: CreateSemesterModel, completion: @escaping (Result<Data?, Error>) -> Void)
    func createEvent(model: CreateEventModel, completion: @escaping (Result<Data?, Error>) -> Void)
    func createThemeSelectionEvent(model: CreateThemeSelectionModel, completion: @escaping (Result<Data?, Error>) -> Void)
    func createDiplomaSpeechEvent(model: CreateDiplomaSpeechModel, completion: @escaping (Result<Data?, Error>) -> Void)
}

class EventsService: EventsServiceProtocol {
    
    private let networkService: NetworkServiceProtocol
    private let requestFactory: EventsURLRequestFactory
    
    init(networkService: NetworkServiceProtocol,
         requestFactory: EventsURLRequestFactory) {
        self.networkService = networkService
        self.requestFactory = requestFactory
    }
    
    func events(completion: @escaping (Result<EventsModel, Error>) -> Void) {
        do {
            let request = try requestFactory.events()
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    func eventDetails(eventID: Int, completion: @escaping (Result<EventDetailServiceModel, Error>) -> Void) {
        do {
            let request = try requestFactory.eventDetails(for: eventID)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    func getModifyEvent(eventID: Int, completion: @escaping (Result<EventDetailServiceModel, Error>) -> Void) {
        do {
            let request = try requestFactory.getModifyEvent(for: eventID)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    func modifyEvent(eventID: Int, eventModel: EventDetailServiceModel, completion: @escaping (Result<Data?, Error>) -> Void) {
        do {
            let request = try requestFactory.modifyEvent(for: eventID, with: eventModel)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    func currentEvents(completion: @escaping (Result<CurrentEventsModel, Error>) -> Void) {
        do {
            let request = try requestFactory.currentEvents()
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    func watchEvent(eventID: Int, completion: @escaping (Result<Data?, Error>) -> Void) {
        do {
            let request = try requestFactory.watchEvent(eventID: eventID)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    func createSemester(model: CreateSemesterModel, completion: @escaping (Result<Data?, Error>) -> Void) {
        do {
            let request = try requestFactory.createSemester(with: model)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    func createEvent(model: CreateEventModel, completion: @escaping (Result<Data?, Error>) -> Void) {
        do {
            let request = try requestFactory.createEvent(with: model)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    func createThemeSelectionEvent(model: CreateThemeSelectionModel, completion: @escaping (Result<Data?, Error>) -> Void) {
        do {
            let request = try requestFactory.createThemeSelectionEvent(with: model)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    func createDiplomaSpeechEvent(model: CreateDiplomaSpeechModel, completion: @escaping (Result<Data?, Error>) -> Void) {
        do {
            let request = try requestFactory.createDiplomaSpeechEvent(with: model)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
}
