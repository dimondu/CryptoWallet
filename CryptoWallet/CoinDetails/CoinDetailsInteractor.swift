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
    
    private weak var presenter: CoinDetailsInteractorOutputProtocol?
    private let coins: Coins
    
    init(presenter: CoinDetailsInteractorOutputProtocol, coins: Coins) {
        self.presenter = presenter
        self.coins = coins
    }
    
    func provideCoinDetails() {
        let dataSrore = CoinDetailsDataStore(
            coinseName: coins.data.name,
            coinPrice: coins.data.marketData.priceUsd,
            changingPrice: coins.data.marketData.percentChangeUsdLast24Hours
        )
        presenter?.receiveCoinDetails(with: dataSrore)
    }
}
