//
//  UserStorageImpl.swift
//  Metamorphosis
//
//  Created by Vladyslav Shkodych on 13.04.2023.
//

import Foundation

final class UserStorageImpl: UserStorage {
    
    let userDefaults: Storable
    
    var weightMeasurements: [String: Double]? {
        get {
            userDefaults.get(for: .weightMeasurements)
        }
        set {
            if let value = newValue {
                userDefaults.set(value: value, for: .weightMeasurements)
            } else {
                userDefaults.delete(for: .weightMeasurements)
            }
        }
    }
    
    init(userDefaults: Storable) {
        self.userDefaults = userDefaults
    }
}
