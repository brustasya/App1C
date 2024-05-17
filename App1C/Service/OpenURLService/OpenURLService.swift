//
//  OpenURLService.swift
//  App1C
//
//  Created by Станислава on 17.05.2024.
//

import UIKit

protocol OpenURLServiceProtocol: AnyObject {
    func openURL(url: String)
}

class OpenURLService: OpenURLServiceProtocol {
    func openURL(url: String) {
        if let url = URL(string: url) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                Logger.shared.printLog(log: "Cannot open URL")
            }
        } else {
            Logger.shared.printLog(log: "Invalid URL")
        }
    }
}
