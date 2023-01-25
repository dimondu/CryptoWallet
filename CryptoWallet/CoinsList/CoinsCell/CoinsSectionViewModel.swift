//
//  CoinsSectionViewModel.swift
//  CryptoWallet
//
//  Created by Дмитрий Дуров on 23.01.2023.
//

import Foundation

final class CoinsSectionViewModel: CoinsSectionViewModelProtocol {
    
    // MARK: Public properties
    
    var rows: [CoinsCellViewModelProtocol] = []
    var numberOfRows: Int {
        rows.count
    }
}
