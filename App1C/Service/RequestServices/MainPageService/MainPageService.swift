//
//  MainPageService.swift
//  App1C
//
//  Created by Станислава on 13.04.2024.
//

import Foundation
import UIKit

protocol MainPageServiceProtocol {
    func getMainPage(completion: @escaping (Result<MainPageModel, Error>) -> Void)
    func updateLinks(with model: LinksModel, completion: @escaping (Result<Data?, Error>) -> Void)
    func openURL(url: String)
}

class MainPageService: MainPageServiceProtocol {
    
    private let networkService: NetworkServiceProtocol
    private let requestFactory: MainPageURLRequestFactory
    
    init(networkService: NetworkServiceProtocol,
         requestFactory: MainPageURLRequestFactory) {
        self.networkService = networkService
        self.requestFactory = requestFactory
    }
    
    func getMainPage(completion: @escaping (Result<MainPageModel, Error>) -> Void) {
        do {
            let request = try requestFactory.getMain()
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    func updateLinks(with model: LinksModel, completion: @escaping (Result<Data?, Error>) -> Void) {
        do {
            let request = try requestFactory.updateLinks(with: model)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    func openURL(url: String) {
        if let url = URL(string: url) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                print("Cannot open URL")
            }
        } else {
            print("Invalid URL")
        }
    }
}

