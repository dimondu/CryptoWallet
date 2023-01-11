//
//  CoinDetailsInteractor.swift
//  CryptoWallet
//
//  Created by Дмитрий Дуров on 28.12.2022.
//

import Foundation


protocol CoinDetailsInteractorInputProtocol {
    init(presenter: CoinDetailsInteractorOutputProtocol)
}

protocol CoinDetailsInteractorOutputProtocol: AnyObject {
    
}

final class CoinDetailsInteractor: CoinDetailsInteractorInputProtocol {
    
    private unowned let presenter: CoinDetailsInteractorOutputProtocol
    
   required init(presenter: CoinDetailsInteractorOutputProtocol) {
        self.presenter = presenter
    }
}
