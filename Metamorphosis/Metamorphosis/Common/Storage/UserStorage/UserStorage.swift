//
//  UserStorage.swift
//  Metamorphosis
//
//  Created by Vladyslav Shkodych on 13.04.2023.
//

import Foundation

protocol UserStorage: AnyObject {
    
    var weightMeasurements: [String: Double]? { get set }
}
