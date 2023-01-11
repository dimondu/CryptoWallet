//
//  SceneDelegate.swift
//  CryptoWallet
//
//  Created by Дмитрий Дуров on 23.12.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        window?.rootViewController = RootViewController()
        window?.makeKeyAndVisible()
        window?.windowScene = windowScene
    }
}

extension SceneDelegate {
    static var shared: SceneDelegate {
        let scene = UIApplication.shared.connectedScenes.first
        guard let sceneDelegate = (scene?.delegate as? SceneDelegate) else {
            return SceneDelegate()
        }
        return sceneDelegate
    }
    
    var rootViewController: RootViewController {
        return window?.rootViewController as! RootViewController
    }
}
