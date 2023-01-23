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
    func fetchCoins()
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
    
    func fetchCoins() {
        NetworkManager.shared.getCoins() { [weak self] coin in
            let dataStore = CoinsListDataStore(coins: coin)
            self?.presenter?.coinsDidReceive(with: dataStore)
        }
    }
    
    func toggleSortingStatus() {
        presenter?.sortingStatusRecive(with: ascendingSorting)
        ascendingSorting.toggle()
    }    
}


