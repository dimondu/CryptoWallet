//
//  CoinsListInteractor.swift
//  CryptoWallet
//
//  Created by Дмитрий Дуров on 27.12.2022.
//

protocol CoinsCellInteractorInputProtocol {
    init(presenter: CoinsCellInteractorOutputProtocol)
}

protocol CoinsCellInteractorOutputProtocol: AnyObject {
    
}

final class CoinsCellInteractor: CoinsCellInteractorInputProtocol {

    private unowned let presenter: CoinsCellInteractorOutputProtocol
    
    // MARK: - Initializers
    
    init(presenter: CoinsCellInteractorOutputProtocol) {
        self.presenter = presenter
    }
}
