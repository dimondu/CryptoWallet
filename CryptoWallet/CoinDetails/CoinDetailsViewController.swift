//
//  CoinDetailsViewController.swift
//  CryptoWallet
//
//  Created by Дмитрий Дуров on 28.12.2022.
//

import UIKit

protocol CoinDetailsViewInputProtocol: AnyObject {
    func displayCoinName(with title: String)
    func displayCoinPrice(with title: String)
    func displayChangingPrice(with title: String)
}

protocol CoinDetailsViewOutputProtocol {
    init(view: CoinDetailsViewInputProtocol)
    func showDetails()
}

final class CoinDetailsViewController: UIViewController {
    
    // MARK: - Public properties
    
    var presenter: CoinDetailsViewOutputProtocol?
    
    // MARK: - Private properties
    
    private let coinPriceLabel: UILabel = {
        let coinPriceLabel = UILabel()
        coinPriceLabel.textAlignment = .center
        coinPriceLabel.numberOfLines = 0
        coinPriceLabel.font = UIFont.systemFont(ofSize: 30)
        coinPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        return coinPriceLabel
    }()
    
    private let coinPriceChaingingLabel: UILabel = {
        let coinPriceChaingingLabel = UILabel()
        coinPriceChaingingLabel.textAlignment = .center
        coinPriceChaingingLabel.numberOfLines = 0
        coinPriceChaingingLabel.font = UIFont.systemFont(ofSize: 20)
        coinPriceChaingingLabel.translatesAutoresizingMaskIntoConstraints = false
        return coinPriceChaingingLabel
    }()
    
    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubview()
        setupAppearance()
        setConstraints()
        presenter?.showDetails()
    }
    
    // MARK: - Private methods
    
    private func addSubview() {
        view.addSubview(coinPriceLabel)
        view.addSubview(coinPriceChaingingLabel)
    }
    
    private func setupAppearance() {
        view.backgroundColor = .white
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            coinPriceLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            coinPriceLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            coinPriceLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            coinPriceChaingingLabel.topAnchor.constraint(equalTo: coinPriceLabel.bottomAnchor, constant: 20),
            coinPriceChaingingLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            coinPriceChaingingLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
}

extension CoinDetailsViewController: CoinDetailsViewInputProtocol {
    func displayCoinName(with title: String) {
        self.title = title
    }
    
    func displayCoinPrice(with title: String) {
        coinPriceLabel.text = title
    }
    
    func displayChangingPrice(with title: String) {
        coinPriceChaingingLabel.text = title
    }
}
