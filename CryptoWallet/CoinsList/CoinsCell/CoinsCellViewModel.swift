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
    var cellIdentifier: String {
        "coinCell"
    }
    
    var cellHeight: Double {
        150
    }
    
    var coinName: String {
        coins.data.name
    }
    
    var coinPrice: Double {
        coins.data.marketData.priceUsd
    }
    
    var coinPriceChainging: Double {
        coins.data.marketData.percentChangeUsdLast24Hours
    }
    
    private let coins: Coins
    
    required init(coins: Coins) {
        self.coins = coins
    }
}

final class CoinsSectionViewModel: CoinsSectionViewModelProtocol {
    var rows: [CoinsCellViewModelProtocol] = []
    var numberOfRows: Int {
        rows.count
    }
}
