//
//  CoinDetailsPresenter.swift
//  CryptoWallet
//
//  Created by Дмитрий Дуров on 28.12.2022.
//

import Foundation


final class CoinDetailsPresenter: CoinDetailsViewOutputProtocol {
    
    var interactor: CoinDetailsInteractorInputProtocol!
    
    private unowned let view: CoinDetailsViewInputProtocol
    
    init(view: CoinDetailsViewInputProtocol) {
        self.view = view
    }
}

extension CoinDetailsPresenter: CoinDetailsInteractorOutputProtocol {
    
}


