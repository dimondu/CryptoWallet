//
//  CoinsListRouter.swift
//  CryptoWallet
//
//  Created by Дмитрий Дуров on 26.12.2022.
//

import Foundation

protocol CoinsListRouterInputProtocol {
    init(view: CoinsListViewController)
    func openAutorizationViewController()
    func openCoinsDetailsViewController(with coins: Coins)
}

final class CoinsListRouter: CoinsListRouterInputProtocol {
    
    // MARK: - Private properties
    
    private weak var view: CoinsListViewController?
    
    // MARK: - Initializers
    
    init(view: CoinsListViewController) {
        self.view = view
    }
    
    // MARK: - Public methods
    
    func openAutorizationViewController() {
        SceneDelegate.shared.rootViewController.switchToLogout()
    }
    
    func openCoinsDetailsViewController(with coins: Coins) {
        let configurator: CoinDetailsConfigurationInputProtocol = CoinDetailsConfigurator()
        let coinDetailViewController = CoinDetailsViewController()
        configurator.confugure(with: coinDetailViewController, and: coins)
        view?.navigationController?.pushViewController(coinDetailViewController, animated: true)
    }
}
