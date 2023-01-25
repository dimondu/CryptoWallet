//
//  AuthorizationRouter.swift
//  CryptoWallet
//
//  Created by Дмитрий Дуров on 23.12.2022.
//

import Foundation

protocol AuthorizationRouterInputProtocol {
    init(view: AuthorizationViewController)
    func openCriptoWalletList()
}

final class AuthorizationRouter: AuthorizationRouterInputProtocol {
    
    // MARK: - Private properties
    
    private weak var view: AuthorizationViewController?
    
    // MARK: - Initializers
    
    required init(view: AuthorizationViewController) {
        self.view = view
    }
    
    // MARK: - Public methods
    
    func openCriptoWalletList() {
        SceneDelegate.shared.rootViewController.switchToCoinsListScreen()
    }
}
