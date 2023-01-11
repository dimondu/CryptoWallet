//
//  CoinDetailsConfigurator.swift
//  CryptoWallet
//
//  Created by Дмитрий Дуров on 28.12.2022.
//

protocol CoinDetailsConfigutationInputProtocol {
    func confugure(with view: CoinDetailsViewController)
}

final class CoinDetailsConfiguration: CoinDetailsConfigutationInputProtocol {
    func confugure(with view: CoinDetailsViewController) {
        let presenter = CoinDetailsPresenter(view: view)
        let interactor = CoinDetailsInteractor(presenter: presenter)
        
        view.presenter = presenter
        presenter.interactor = interactor

    }
}
