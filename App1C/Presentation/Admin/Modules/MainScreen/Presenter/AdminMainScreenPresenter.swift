//
//  AdminMainScreenPresenter.swift
//  App1C
//
//  Created by Станислава on 17.04.2024.
//

import Foundation

final class AdminMainScreenPresenter {
    weak var viewInput: AdminMainScreenViewInput?
    weak var moduleOutput: AdminMainScreenModuleOutput?
    
    private let mainScreenService: MainPageServiceProtocol
    
    private lazy var tgLink = " "
    private lazy var chatbotLink = " "
    private lazy var siteLink = " "
    
    init(
        moduleOutput: AdminMainScreenModuleOutput,
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
                DispatchQueue.main.async {
                    self?.viewInput?.setupBell(newEvents: model.unseenEvents ?? false)
                    if model.startedCourseAggregation {
                        self?.viewInput?.setupCourseAggregationButton()
                    }
                }
            case .failure(let failure):
                Logger.shared.printLog(log: "Failed load main page: \(failure)")
            }
        }
    }
    
    private func updateLinks(tgURL: String? = nil, chatbotURL: String? = nil, siteURL: String? = nil) {
        let tgURL = tgURL ?? tgLink
        let chatbotURL = chatbotURL ?? chatbotLink
        let siteURL = siteURL ?? siteLink
        
        mainScreenService.updateLinks(with: LinksModel(telegramChannelURL: tgURL, telegramBotURL: chatbotURL, siteURL: siteURL)) { result in
            switch result {
            case .success(_):
                Logger.shared.printLog(log: "Sucsess update urls")
            case .failure(let failure):
                Logger.shared.printLog(log: "Failed update urls: \(failure)")
            }
        }
    }
}

extension AdminMainScreenPresenter: AdminMainScreenViewOutput {
    func openNotifications() {
        moduleOutput?.moduleWantsToOpenNotifications()
    }
    
    func openDepartmentCourses() {
        moduleOutput?.moduleWantsToOpenCourses()
    }
    
    func courseAggregationButtonTapped() {
        moduleOutput?.moduleWantsToOpenCourseAggregation()
    }
    
    func viewIsReady() {
        getMainPage()
    }
    
    func updateTelegramURL(url: String) {
        updateLinks(tgURL: url)
    }
    
    func updateChatbotURL(url: String) {
        updateLinks(chatbotURL: url)
    }
    
    func updateSiteURL(url: String) {
        updateLinks(siteURL: url)
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
