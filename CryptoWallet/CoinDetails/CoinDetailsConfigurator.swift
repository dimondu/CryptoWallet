//
//  CoinDetailsConfigurator.swift
//  CryptoWallet
//
//  Created by Дмитрий Дуров on 28.12.2022.
//

protocol CoinDetailsConfigutationInputProtocol {
    func confugure(with view: CoinDetailsViewController, and coins: Coins)
}

final class CoinDetailsConfigurator: CoinDetailsConfigutationInputProtocol {
    
    // MARK: - Public methods
    
    func confugure(with view: CoinDetailsViewController, and coins: Coins) {
        let presenter = CoinDetailsPresenter(view: view)
        let interactor = CoinDetailsInteractor(presenter: presenter, coins: coins)
        
        view.presenter = presenter
        presenter.interactor = interactor
    }
}
