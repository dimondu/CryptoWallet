//
//  CoinDetailsPresenter.swift
//  CryptoWallet
//
//  Created by Дмитрий Дуров on 28.12.2022.
//

import Foundation

struct CoinDetailsDataStore {
    let coinseName: String
    let coinPrice: Double
    let changingPrice: Double
}

final class CoinDetailsPresenter: CoinDetailsViewOutputProtocol {
    
    var interactor: CoinDetailsInteractorInputProtocol?
    
    private weak var view: CoinDetailsViewInputProtocol?
    
    init(view: CoinDetailsViewInputProtocol) {
        self.view = view
    }
    
    func showDetails() {
        interactor?.provideCoinDetails()
    }
}

extension CoinDetailsPresenter: CoinDetailsInteractorOutputProtocol {
    func receiveCoinDetails(with dataStore: CoinDetailsDataStore) {
        let coinPrice = "Price:" + " " + String(format: "%.3f" , dataStore.coinPrice) + "$"
        let coinChangingPrice = "Changing last 24 hours:" + " " + String(format: "%.3f" , dataStore.changingPrice) + "%"
        view?.displayCoinName(with: dataStore.coinseName)
        view?.displayCoinPrice(with: coinPrice)
        view?.displayChangingPrice(with: coinChangingPrice)
    }
    
    
}


