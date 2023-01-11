//
//  AuthorizationConfigurator.swift
//  CryptoWallet
//
//  Created by Дмитрий Дуров on 23.12.2022.
//

import Foundation


protocol AuthorizationConfigurationInputProtocol {
    func configure(withView view: AuthorizationViewController)
}

final class AuthorizationConfigurator: AuthorizationConfigurationInputProtocol {
    
    // MARK: - Public methods
    
    func configure(withView view: AuthorizationViewController) {
        let presenter = AuthorizationPresenter(view: view)
        let interactor = AuthorizationInteractor(presenter: presenter)
        let router = AuthorizationRouter(view: view)
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
