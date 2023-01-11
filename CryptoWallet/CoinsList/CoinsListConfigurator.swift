//
//  CoinsListConfigurator.swift
//  CryptoWallet
//
//  Created by Дмитрий Дуров on 26.12.2022.
//

import Foundation

protocol CoinsListConfigutationInputProtocol {
    func confugure(with view: CoinsListViewController)
}

final class CoinsListConfiguration: CoinsListConfigutationInputProtocol {
    
    // MARK: - Public methods
    
    func confugure(with view: CoinsListViewController) {
        let presenter = CoinsListPresenter(view: view)
        let interactor = CoinsListInteractor(presenter: presenter)
        let router = CoinsListRouter(view: view)
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
