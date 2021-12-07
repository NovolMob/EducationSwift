//
//  DataStorage.swift
//  FirstApplication
//
//  Created by Antares on 07.12.2021.
//

import UIKit
class DataStorage {
    private let LABEL_KEY = "first_tab_label"
    
    static let instance: DataStorage = DataStorage()
    var keychainLabel: String? {
        didSet {
            guard let label = keychainLabel else { return }
            KeychainWrapper.setValue(forKey: LABEL_KEY, label.data(using: .utf8)!)
        }
    }
    var userDefaultLabel: String? {
        didSet {
            UserDefaults.standard.set(userDefaultLabel, forKey: LABEL_KEY)
        }
    }
    
    private init() {
        userDefaultLabel = UserDefaults.standard.string(forKey: LABEL_KEY)
        guard let data = KeychainWrapper.getValue(forKey: LABEL_KEY) else { return }
        keychainLabel = String(data: data, encoding: .utf8)
    }
}
