//
//  TeacherMainScreenPresenter.swift
//  App1C
//
//  Created by Станислава on 20.04.2024.
//

import Foundation

final class TeacherMainScreenPresenter {
    weak var viewInput: TeacherMainScreenViewInput?
    weak var moduleOutput: TeacherMainScreenModuleOutput?
    
    private let mainScreenService: MainPageServiceProtocol
    
    private lazy var tgLink = " "
    private lazy var chatbotLink = " "
    private lazy var siteLink = " "
    private lazy var events: [EventModel] = []
    
    init(
        moduleOutput: TeacherMainScreenModuleOutput,
        mainScreenService: MainPageServiceProtocol
    ) {
        self.moduleOutput = moduleOutput
        self.mainScreenService = mainScreenService
    }
    
    private func getMainPage() {
        mainScreenService.getMainPage() { [weak self] result in
            switch result {
            case .success(let model):
                Logger.shared.printLog(log: "\(model)")
                self?.tgLink = model.telegramChannelURL
                self?.chatbotLink = model.telegramBotURL
                self?.siteLink = model.siteURL
                TokenService.shared.chatURL = model.telegramChannelURL
                let events = model.events.map({
                    EventModel(id: $0.id, title: $0.title,
                               deadline: Date.toDate(dateString: $0.deadline ) ,
                               type: (self?.getEventType(type: $0.title)) ?? .estimating)
                    
                })
                self?.events = events
                DispatchQueue.main.async {
                    self?.viewInput?.setupBell(newEvents: model.unseenEvents ?? false)
                    self?.viewInput?.updateEvents(events: events)
                }
            case .failure(let failure):
                Logger.shared.printLog(log: "Failed load main page: \(failure)")
            }
        }
    }
    
    private func getEventType(type: String) -> EventType {
        switch type {
        case EventType.preliminaryCourseChoice.title:
            return .preliminaryCourseChoice
        case EventType.finalCourseChoice.title:
            return .finalCourseChoice
        case EventType.estimating.title:
            return .estimating
        default:
            return .estimating
        }
    }
}

extension TeacherMainScreenPresenter: TeacherMainScreenViewOutput {
    func openNotifications() {
        moduleOutput?.moduleWantsToOpenNotifications()
    }
    
    func selectEvent(at index: Int) {
        moduleOutput?.moduleWantsToOpenEvent(id: events[index].id)
    }
    
    func viewIsReady() {
        getMainPage()
    }
    
    func openTelegram() {
        mainScreenService.openURL(url: tgLink)
    }
    
    func openChatbot() {
        mainScreenService.openURL(url: chatbotLink)
    }
    
    func openSite() {
        mainScreenService.openURL(url: siteLink)
    }
}
