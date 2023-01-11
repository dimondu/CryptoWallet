//
//  CoinDetailsViewController.swift
//  CryptoWallet
//
//  Created by Дмитрий Дуров on 28.12.2022.
//

import UIKit

protocol CoinDetailsViewInputProtocol: AnyObject {
    
}

protocol CoinDetailsViewOutputProtocol {
    init(view: CoinDetailsViewInputProtocol)
}


final class CoinDetailsViewController: UIViewController {
    
    // MARK: - Public properties
    
    var presenter: CoinDetailsViewOutputProtocol!
    
    // MARK: - Private properties
    
    private lazy var coinPriceLabel: UILabel = {
       let coinPriceLabel = UILabel()
        coinPriceLabel.text = "1621212 $"
        coinPriceLabel.textAlignment = .center
        coinPriceLabel.font = UIFont.systemFont(ofSize: 35)
        coinPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        return coinPriceLabel
    }()
    
    private lazy var coinPriceChaingingLabel: UILabel = {
        let coinPriceChaingingLabel = UILabel()
        coinPriceChaingingLabel.text = "0.01222 %"
        coinPriceChaingingLabel.textAlignment = .center
        coinPriceChaingingLabel.font = UIFont.systemFont(ofSize: 25)
        coinPriceChaingingLabel.translatesAutoresizingMaskIntoConstraints = false
        return coinPriceChaingingLabel
    }()
    
    private lazy var logOutButton: LogOutButton = {
        let logOutButton = LogOutButton(type: .system)
        logOutButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        return logOutButton
    }()
    
    private let configurator: CoinDetailsConfigutationInputProtocol = CoinDetailsConfiguration()
    
    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Bitcoin"
        view.backgroundColor = .white
        
        view.addSubview(coinPriceLabel)
        view.addSubview(coinPriceChaingingLabel)
        view.addSubview(logOutButton)
        
        configurator.confugure(with: self)
        setConstraints()
    }
    
    // MARK: - Private methods
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            coinPriceLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            coinPriceLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            coinPriceLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 20),
            
            coinPriceChaingingLabel.topAnchor.constraint(equalTo: coinPriceLabel.bottomAnchor, constant: 20),
            coinPriceChaingingLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            coinPriceChaingingLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 20),
            
            logOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            logOutButton.widthAnchor.constraint(equalToConstant: 150),
            logOutButton.heightAnchor.constraint(equalToConstant: 50),
            logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }    
}

extension CoinDetailsViewController: CoinDetailsViewInputProtocol {
    
}
