//
//  CoinsListPresenter.swift
//  CryptoWallet
//
//  Created by Дмитрий Дуров on 27.12.2022.
//

final class CoinsCellPresenter: CoinsCellViewOutputProtocol {
   
    var interactor: CoinsCellInteractorInputProtocol!
    
    private unowned let view: CoinsCellViewInputProtocol
    
    // MARK: - Initializers
    
    init(view: CoinsCellViewInputProtocol) {
        self.view = view
    }
}

extension CoinsCellPresenter: CoinsCellInteractorOutputProtocol {
    
}
