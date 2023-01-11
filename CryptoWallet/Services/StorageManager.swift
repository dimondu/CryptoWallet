//
//  StorageManager.swift
//  CryptoWallet
//
//  Created by Дмитрий Дуров on 25.12.2022.
//

import Foundation


final class StorageManager {
    static let shared = StorageManager()
    
    private let defaults = UserDefaults.standard
    private let userKey = "user"
    
    private init() {}
    
}
