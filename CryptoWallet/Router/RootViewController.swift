//
//  RootViewController.swift
//  CryptoWallet
//
//  Created by Дмитрий Дуров on 07.01.2023.
//

import UIKit

final class RootViewController: UIViewController {
    
    // MARK: - Private properties
    
    private var current: UIViewController
    
    // MARK: - Initializers
    
    init() {
        current = SplashViewController()
        super.init(nibName:  nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(current)
        current.view.frame = view.bounds
        view.addSubview(current.view)
        current.didMove(toParent: self)
    }
    
    // MARK: - Public methods
    
    func showAuthorizationScreen() {
        let authorizationScreen = UINavigationController(rootViewController: AuthorizationViewController())
        
        addChild(authorizationScreen)
        authorizationScreen.view.frame = view.bounds
        view.addSubview(authorizationScreen.view)
        authorizationScreen.didMove(toParent: self)
        
        current.willMove(toParent: nil)
        current.view.removeFromSuperview()
        current.removeFromParent()
        
        current = authorizationScreen
    }
    
    func switchToLogout() {
        let authorizationViewController = AuthorizationViewController()
        let logoutScreen = UINavigationController(rootViewController: authorizationViewController)
        animateDismissTransition(to: logoutScreen)
    }
    
    func switchToCoinsListScreen() {
        let coinsListViewController = CoinsListViewController()
        let new = UINavigationController(rootViewController: coinsListViewController)
        animateFadeTransition(to: new)
    }
    
    // MARK: - Private methods
    
    private func animateFadeTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
        current.willMove(toParent: nil)
        addChild(new)
        transition(from: current, to: new, duration: 0.3, options: [.transitionCrossDissolve, .curveEaseOut], animations: {
            
        }) { completed in
            self.current.removeFromParent()
            new.didMove(toParent: self)
            self.current = new
            completion?()
        }
    }
    
    private func animateDismissTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
        
        let initialFrame = CGRect(x: -view.bounds.width, y: 0, width: view.bounds.width, height: view.bounds.height)
        current.willMove(toParent: nil)
        addChild(new)
        new.view.frame = initialFrame
        
        transition(from: current, to: new, duration: 0.3, options: [], animations: {
            new.view.frame = self.view.bounds
        }) { completed in
            self.current.removeFromParent()
            new.didMove(toParent: self)
            self.current = new
            completion?()
        }
    }
}
