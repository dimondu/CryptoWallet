//
//  CoinsListPresenter.swift
//  CryptoWallet
//
//  Created by Дмитрий Дуров on 26.12.2022.
//

final class CoinsListPresenter: CoinsListViewOutputProtocol {
    
    // MARK: - Public properties
    
    var interactor: CoinsListInteractorInputProtocol!
    var router: CoinsListRouterInputProtocol!
    
    // MARK: - Private properties
    
    private weak var view: CoinsListViewInputProtocol!
    
    // MARK: - Initializers
    
    required init(view: CoinsListViewInputProtocol) {
        self.view = view
    }
}

// MARK: - CoinsListInteractorOutputProtocol

extension CoinsListPresenter: CoinsListInteractorOutputProtocol {
    
    func logout() {
        interactor.changeLoginStatus()
    }
    
    func exitTheScreen() {
        router.openAutorizationViewController()
    }
}
