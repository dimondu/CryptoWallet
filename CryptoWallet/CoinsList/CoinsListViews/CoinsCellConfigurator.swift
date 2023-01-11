//
//  CoinsListConfigurator.swift
//  CryptoWallet
//
//  Created by Дмитрий Дуров on 27.12.2022.
//


protocol CoinsCellConfigutationInputProtocol {
    func confugure(with view: CoinsViewCell)
}

final class CoinsCellConfiguration: CoinsCellConfigutationInputProtocol {
    func confugure(with view: CoinsViewCell) {
        let presenter = CoinsCellPresenter(view: view)
        let interactor = CoinsCellInteractor(presenter: presenter)
        
        view.presenter = presenter
        presenter.interactor = interactor
    }
}
