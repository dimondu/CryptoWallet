//
//  AuthorizationInteractor.swift
//  CryptoWallet
//
//  Created by Дмитрий Дуров on 23.12.2022.
//

import Foundation

struct UserData {
    let login = "1234"
    let password = "1234"
}

protocol AuthorizationInteractorInputProtocol {
    init(presenter: AuthorizationInteractorOutputProtocol)
    func checkValidateData(with login: String, password: String)
}

protocol AuthorizationInteractorOutputProtocol: AnyObject {
    func didEnterInAccount(with login: String, password: String)
    func didReceive()
}

final class AuthorizationInteractor: AuthorizationInteractorInputProtocol {
    
    // MARK: - Private properties
    
    private weak var presenter: AuthorizationInteractorOutputProtocol!
    
    private let userData = UserData()
    
    // MARK: - Initializers
    
    required init(presenter: AuthorizationInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    // MARK: - Public methods
    
    func checkValidateData(with login: String, password: String) {
        
        if login == userData.login, password == userData.password {
            presenter.didEnterInAccount(with: login, password: password)
            UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
        } else {
            presenter.didReceive()
        }
    }
}

