//
//  CoinDetailsInteractor.swift
//  CryptoWallet
//
//  Created by Дмитрий Дуров on 28.12.2022.
//

import Foundation

protocol CoinDetailsInteractorInputProtocol {
    init(presenter: CoinDetailsInteractorOutputProtocol, coins: Coins)
    func provideCoinDetails()
}

protocol CoinDetailsInteractorOutputProtocol: AnyObject {
    func receiveCoinDetails(with dataStore: CoinDetailsDataStore)
}

final class CoinDetailsInteractor: CoinDetailsInteractorInputProtocol {
    
    // MARK: - Private properties
    
    private weak var presenter: CoinDetailsInteractorOutputProtocol?
    private let coins: Coins
    
    // MARK: - Initializers
    
    init(presenter: CoinDetailsInteractorOutputProtocol, coins: Coins) {
        self.presenter = presenter
        self.coins = coins
    }
    
    // MARK: - Public methods
    
    func provideCoinDetails() {
        let dataStore = CoinDetailsDataStore(
            coinseName: coins.data.name ?? "Not found",
            coinPrice: coins.data.marketData.priceUsd ?? 0,
            changingPrice: coins.data.marketData.percentChangeUsdLast24Hours ?? 0 
        )
        presenter?.receiveCoinDetails(with: dataStore)
    }
}
