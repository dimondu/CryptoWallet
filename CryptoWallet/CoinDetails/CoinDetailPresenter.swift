//
//  CoinDetailsPresenter.swift
//  CryptoWallet
//
//  Created by Дмитрий Дуров on 28.12.2022.
//

import Foundation

final class CoinDetailsPresenter: CoinDetailsViewOutputProtocol {
    
    // MARK: - Public properties
    
    var interactor: CoinDetailsInteractorInputProtocol?
    
    // MARK: - Private properties
    
    private weak var view: CoinDetailsViewInputProtocol?
    
    // MARK: - Initializers
    
    init(view: CoinDetailsViewInputProtocol) {
        self.view = view
    }
    
    // MARK: - Public methods
    
    func showDetails() {
        interactor?.provideCoinDetails()
    }
}

// MARK: - CoinDetailsInteractorOutputProtocol

extension CoinDetailsPresenter: CoinDetailsInteractorOutputProtocol {
    func receiveCoinDetails(with dataStore: CoinDetailsDataStore) {
        let coinPrice = "Price:" + " " + String(format: "%.3f" , dataStore.coinPrice) + "$"
        let coinChangingPrice = "Changing last 24 hours:" + " " + String(format: "%.3f" , dataStore.changingPrice) + "%"
        view?.displayCoinName(with: dataStore.coinseName)
        view?.displayCoinPrice(with: coinPrice)
        view?.displayChangingPrice(with: coinChangingPrice)
    }
}


