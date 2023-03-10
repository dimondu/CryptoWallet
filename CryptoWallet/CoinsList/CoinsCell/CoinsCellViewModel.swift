//
//  CoinsCellViewModel.swift
//  CryptoWallet
//
//  Created by Дмитрий Дуров on 17.01.2023.
//

import Foundation

protocol CoinsCellViewModelProtocol {
    var cellIdentifier: String { get }
    var cellHeight: Double { get }
    var coinName: String { get }
    var coinPrice: Double { get }
    var coinPriceChainging: Double { get }
    init(coins: Coins)
}

protocol CoinsSectionViewModelProtocol {
    var rows: [CoinsCellViewModelProtocol] { get }
    var numberOfRows: Int { get }
}

final class CoinsCellViewModel: CoinsCellViewModelProtocol {
    
    // MARK: - Public properties
    
    var cellIdentifier: String {
        "coinCell"
    }
    
    var cellHeight: Double {
        150
    }
    
    var coinName: String {
        coins.data.name ?? "Not Found"
    }
    
    var coinPrice: Double {
        coins.data.marketData.priceUsd ?? 0
    }
    
    var coinPriceChainging: Double {
        coins.data.marketData.percentChangeUsdLast24Hours ?? 0
    }
    
    // MARK: - Private properties
    
    private let coins: Coins
    
    // MARK: - Initializers
    
    init(coins: Coins) {
        self.coins = coins
    }
}
