//
//  AuthorizationPresenter.swift
//  CryptoWallet
//
//  Created by Дмитрий Дуров on 23.12.2022.
//

import Foundation

final class AuthorizationPresenter: AuthorizationViewOutputProtocol {
    
    // MARK: - Public properties
    
    var interactor: AuthorizationInteractorInputProtocol?
    var router: AuthorizationRouterInputProtocol?
    
    // MARK: - Private properties
    
   private weak var view: AuthorizationViewInputProtocol?
    
    // MARK: - Initializers
    
    required init(view: AuthorizationViewInputProtocol) {
        self.view = view
    }
    
    // MARK: - Public methods
    
    func userLogInAccount(with login: String, password: String) {
        interactor?.checkValidateData(with: login, password: password)
    }
}

// MARK: - AuthorizationInteractorOutputProtocol

extension AuthorizationPresenter: AuthorizationInteractorOutputProtocol {
    func didEnterInAccount(with login: String, password: String) {
        router?.openCriptoWalletList()
    }
    
    func didReceive() {
        view?.showAlert()
    }
}


