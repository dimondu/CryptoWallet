//
//  CoinsListInteractor.swift
//  CryptoWallet
//
//  Created by Дмитрий Дуров on 26.12.2022.
//

import Foundation

protocol CoinsListInteractorInputProtocol {
    init(presenter: CoinsListInteractorOutputProtocol)
    func changeLoginStatus()
    func getCoins()
    func toggleSortingStatus()
}

protocol CoinsListInteractorOutputProtocol: AnyObject {
    func exitTheScreen()
    func coinsDidReceive(with dataStore: CoinsListDataStore)
    func sortingStatusRecive(with toggle: Bool)
}

final class CoinsListInteractor: CoinsListInteractorInputProtocol {
    
    // MARK: - Private properties
    
    private weak var presenter: CoinsListInteractorOutputProtocol?
    private let coinNames = ["btc", "eth", "tron",
                             "luna", "polkadot", "dogecoin",
                             "tether", "stellar", "cardano", "xrp"]
    private var ascendingSorting = true
    
    // MARK: - Initializers
    
    required init(presenter: CoinsListInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    // MARK: - Public methods
    
    func changeLoginStatus() {
        UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
        presenter?.exitTheScreen()
    }
    
    func toggleSortingStatus() {
        presenter?.sortingStatusRecive(with: ascendingSorting)
        ascendingSorting.toggle()
    }
    
    func getCoins() {
        let coinGroup = DispatchGroup()
        var coins: [Coins] = []
        
        for coinName in coinNames {
            coinGroup.enter()
            NetworkManager.shared.fetch(Coins.self, for: makeCoinRequest(coinName: coinName)) { result in
                switch result {
                case .success(let coin):
                    coins.append(coin)
                    coinGroup.leave()
                case .failure(let error):
                    print(error.localizedDescription)
                    coinGroup.leave()
                }
            }
        }
        coinGroup.notify(queue: .main) {
            let dataStore = CoinsListDataStore(coins: coins)
            self.presenter?.coinsDidReceive(with: dataStore)
        }
    }
    
    // MARK: - Private methods
    
    private func makeCoinRequest(coinName: String) -> String {
        "https://data.messari.io/api/v1/assets/\(coinName)/metrics"
    }
}


