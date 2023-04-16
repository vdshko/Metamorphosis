//
//  UserStorageImpl.swift
//  Metamorphosis
//
//  Created by Vladyslav Shkodych on 13.04.2023.
//

import Foundation

final class UserStorageImpl: UserStorage {
    
    let userDefaults: Storable
    
    // MARK: - WeightViewModel
    
    var measurementMultiplierToMG: [String: Double]? {
        get {
            userDefaults.get(for: .measurementMultiplierToMG)
        }
        set {
            if let value = newValue {
                userDefaults.set(value: value, for: .measurementMultiplierToMG)
            } else {
                userDefaults.delete(for: .measurementMultiplierToMG)
            }
        }
    }
    
    var measurementMultiplierFromMG: [String: Double]? {
        get {
            userDefaults.get(for: .measurementMultiplierFromMG)
        }
        set {
            if let value = newValue {
                userDefaults.set(value: value, for: .measurementMultiplierFromMG)
            } else {
                userDefaults.delete(for: .measurementMultiplierFromMG)
            }
        }
    }
    
    init(userDefaults: Storable) {
        self.userDefaults = userDefaults
    }
}
