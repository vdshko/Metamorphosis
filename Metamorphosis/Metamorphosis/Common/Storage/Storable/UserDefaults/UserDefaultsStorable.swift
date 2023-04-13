//
//  UserDefaultsStorable.swift
//  Metamorphosis
//
//  Created by Vladyslav Shkodych on 13.04.2023.
//

import Foundation

final class UserDefaultsStorable: Storable {
    
    private let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
    
    @discardableResult
    func set<T: Encodable>(value: T, for key: Storage.Key) -> Bool {
        let encoder = JSONEncoder()
        guard let data: Data = try? encoder.encode(value) else {
            return false
        }
        
        userDefaults.set(data, forKey: key.rawValue)

        return true
    }
    
    func get<T>(for key: Storage.Key) -> T? where T: Decodable {
        guard let data = userDefaults.object(forKey: key.rawValue) as? Data else {
            return nil
        }
        
        let decoder = JSONDecoder()
        
        return try? decoder.decode(T.self, from: data)
    }
    
    @discardableResult
    func delete(for key: Storage.Key) -> Bool {
        userDefaults.removeObject(forKey: key.rawValue)
        
        return true
    }
    
    @discardableResult
    func clear() -> Bool {
        Storage.Key.allCases.forEach { delete(for: $0) }
        
        return true
    }
}
