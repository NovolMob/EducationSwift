//
//  KeychainWrapper.swift
//  FirstApplication
//
//  Created by Antares on 30.11.2021.
//

import Foundation
class KeychainWrapper {
    static let APPLICATION_NAMESPACE = "first-app"
    
    static func setValue(forKey key: String, _ value: Data) {
        var query: [String: Any] = createQuery(forKey: key)
        var status: OSStatus = SecItemUpdate(query as CFDictionary, [kSecValueData as String: value] as CFDictionary)
        if (status == errSecItemNotFound) {
            query[kSecValueData as String] = value
            status = SecItemAdd(query as CFDictionary, nil)
            if (status != errSecSuccess) {
                print("Данные не сохранены в Keychain!")
            }
        }
    }
    
    static func addValue(forKey key: String, _ value: Data) {
        var addquery: [String: Any] = createQuery(forKey: key)
        addquery[kSecValueData as String] = value
        let status: OSStatus = SecItemAdd(addquery as CFDictionary, nil)
        if (status != errSecSuccess) {
            print("Данные не сохранены в Keychain!")
        }
    }
    
    static func getValue(forKey key: String) -> Data? {
        var getquery: [String: Any] = createQuery(forKey: key)
        getquery[kSecMatchLimit as String] = kSecMatchLimitOne
        getquery[kSecReturnData as String] = kCFBooleanTrue
        var item: AnyObject?
        SecItemCopyMatching(getquery as CFDictionary, &item)
        return item as? Data
    }
    
    static func updateValue(forKey key: String, _ value: Data) {
        let query: [String: Any] = createQuery(forKey: key)
        SecItemUpdate(query as CFDictionary, [kSecValueData as String: value] as CFDictionary)
    }
    
    static func generateTag(forKey: String) -> Data {
        return "\(APPLICATION_NAMESPACE).\(forKey)".data(using: .utf8)!
    }
    
    static func createQuery(forKey: String) -> [String:Any] {
        let tag = generateTag(forKey: forKey)
        let query: [String: Any] = [kSecClass as String: kSecClassKey,
                                    kSecAttrApplicationTag as String: tag]
        return query
    }
}
