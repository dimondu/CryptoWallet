//
//  CoinsListPresenter.swift
//  CryptoWallet
//
//  Created by Дмитрий Дуров on 26.12.2022.
//

import Foundation

struct CoinsListDataStore {
    var coins: [Coins]
}

final class CoinsListPresenter: CoinsListViewOutputProtocol {
    
    // MARK: - Public properties
    
    var interactor: CoinsListInteractorInputProtocol?
    var router: CoinsListRouterInputProtocol?
    
    // MARK: - Private properties
    
    private weak var view: CoinsListViewInputProtocol?
    
    private var dataStore: CoinsListDataStore?
    
    
    // MARK: - Initializers
    
    required init(view: CoinsListViewInputProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        interactor?.fetchCoins()
    }
    
    func sortingButtonPressed() {
        interactor?.toggleSortingStatus()
    }
    
    func didTapCell(at indexPath: IndexPath) {
        guard let coins = dataStore?.coins[indexPath.row] else { return }
        router?.openCoinsDetailsViewController(with: coins)
    }
}

// MARK: - CoinsListInteractorOutputProtocol

extension CoinsListPresenter: CoinsListInteractorOutputProtocol {
    
    func logout() {
        interactor?.changeLoginStatus()
    }
    
    func exitTheScreen() {
        router?.openAutorizationViewController()
    }
    
    func coinsDidReceive(with dataStore: CoinsListDataStore) {
        self.dataStore = dataStore
        let section = CoinsSectionViewModel()
        dataStore.coins.forEach { section.rows.append(CoinsCellViewModel(coins: $0)) }
        view?.reloadData(for: section)
    }
    
    func sortingStatusRecive(with toggle: Bool) {
        var filteredCoins: [Coins] = []
        let section = CoinsSectionViewModel()
        if toggle {
            filteredCoins = dataStore?.coins.sorted {$0.data.marketData.percentChangeUsdLast24Hours < $1.data.marketData.percentChangeUsdLast24Hours } ?? []
        } else {
            filteredCoins = dataStore?.coins.sorted { $0.data.marketData.percentChangeUsdLast24Hours > $1.data.marketData.percentChangeUsdLast24Hours } ?? []
        }
        filteredCoins.forEach { section.rows.append(CoinsCellViewModel(coins: $0)) }
        dataStore?.coins = filteredCoins
        view?.reloadData(for: section)
    }
}
