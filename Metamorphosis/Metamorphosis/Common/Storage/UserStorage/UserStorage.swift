//
//  UserStorage.swift
//  Metamorphosis
//
//  Created by Vladyslav Shkodych on 13.04.2023.
//

import Foundation

protocol UserStorage: AnyObject {
    
    var measurementMultiplierToMG: [String: Double]? { get set }
    var measurementMultiplierFromMG: [String: Double]? { get set }
}
