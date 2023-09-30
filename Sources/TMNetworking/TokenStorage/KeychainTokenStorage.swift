//
//  KeychainTokenStorage.swift
//
//
//  Created by Dmitry Maslennikov on 30.09.2023.
//

import Foundation
import OSLog

public final class KeychainTokenStorage: TokenStorage {
    
    private let logger = Logger()
    private let account = "TaskManager"
    
    public var accessToken: String? {
        get {
            do {
                guard let token = try KeychainManager.get(account: account) else { return nil }
                return String(data: token, encoding: .utf8)
            } catch {
                logger.error("TMNetworking.KeychainTokenStorage get - \(error)")
                return nil
            }
        }
        set {
            do {
                if let token = newValue {
                    try KeychainManager.save(accessToken: Data(token.utf8), account: account)
                } else {
                    try KeychainManager.delete(account: account)
                }
            } catch {
                logger.error("TMNetworking.KeychainTokenStorage set - \(error)")
            }
        }
    }
}
