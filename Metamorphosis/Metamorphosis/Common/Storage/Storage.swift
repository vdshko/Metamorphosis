//
//  Storage.swift
//  Metamorphosis
//
//  Created by Vladyslav Shkodych on 13.04.2023.
//

import Foundation

final class Storage {
    
    static let shared: Storage = Storage()
    
    let userStorage: UserStorage
    
    private init() {
        userStorage = UserStorageImpl(userDefaults: UserDefaultsStorable())
    }
    
    // MARK: - Preview
    
    static var preview: Storage {
        return Storage(userStorage: UserStorageMock())
    }
    
    private init(userStorage: UserStorage) {
        self.userStorage = userStorage
    }
}

extension Storage {
    
    enum Key: String, CaseIterable {
        
        case measurementMultiplierToMG
        case measurementMultiplierFromMG
    }
}
