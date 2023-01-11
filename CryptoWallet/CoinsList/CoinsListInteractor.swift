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
}

protocol CoinsListInteractorOutputProtocol: AnyObject {
    func exitTheScreen()
}

final class CoinsListInteractor: CoinsListInteractorInputProtocol {
    
    // MARK: - Private properties
    
    private weak var presenter: CoinsListInteractorOutputProtocol!
    
    // MARK: - Initializers
    
    required init(presenter: CoinsListInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    // MARK: - Public methods
    
    func changeLoginStatus() {
        UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
        presenter.exitTheScreen()
    }
}

