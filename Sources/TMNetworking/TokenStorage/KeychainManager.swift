//
//  KeychainManager.swift
//
//
//  Created by Dmitry Maslennikov on 30.09.2023.
//

import Foundation

enum KeychainError: Error {
    case unowned(status: OSStatus)
}

final class KeychainManager {
    
    static func save(accessToken: Data, account: String) throws {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecValueData: accessToken
        ] as CFDictionary
        
        var status = SecItemAdd(query, nil)
        
        if status == errSecDuplicateItem {
            let attributesToUpdate = [kSecValueData: accessToken] as CFDictionary
            status = SecItemUpdate(query, attributesToUpdate)
        }
        
        guard status == errSecSuccess else { throw KeychainError.unowned(status: status) }
    }
    
    static func get(account: String) throws -> Data? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecReturnData: kCFBooleanTrue as Any
        ] as CFDictionary
        
        var result: AnyObject?
        
        let status = SecItemCopyMatching(query, &result)
        
        guard status == errSecSuccess else { throw KeychainError.unowned(status: status) }
        
        return result as? Data
    }
    
    static func delete(account: String) throws {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account
        ] as CFDictionary
        
        let status = SecItemDelete(query)
        
        guard status == errSecSuccess else { throw KeychainError.unowned(status: status) }
    }
}
