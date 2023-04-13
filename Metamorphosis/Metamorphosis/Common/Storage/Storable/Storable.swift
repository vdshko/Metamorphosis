//
//  Storable.swift
//  Metamorphosis
//
//  Created by Vladyslav Shkodych on 13.04.2023.
//

import Foundation

protocol Storable {
    
    @discardableResult
    func set<T: Encodable>(value: T, for key: Storage.Key) -> Bool
    
    func get<T>(for key: Storage.Key) -> T? where T: Decodable
    
    @discardableResult
    func delete(for key: Storage.Key) -> Bool
    
    @discardableResult
    func clear() -> Bool
}
