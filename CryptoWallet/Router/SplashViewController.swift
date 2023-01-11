//
//  SplashViewController.swift
//  CryptoWallet
//
//  Created by Дмитрий Дуров on 07.01.2023.
//

import UIKit

final class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        makeServiceCall()
    }
    
    private func makeServiceCall() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
            if UserDefaults.standard.bool(forKey: "isUserLoggedIn") {
                SceneDelegate.shared.rootViewController.switchToCoinsListScreen()
            } else {
                SceneDelegate.shared.rootViewController.showAuthorizationScreen()
            }
        }
    }
}
