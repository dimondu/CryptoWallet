//
//  CoinsCell.swift
//  CryptoWallet
//
//  Created by Дмитрий Дуров on 27.12.2022.
//

import UIKit

protocol CoinsCellViewInputProtocol: AnyObject {
    
}

protocol CoinsCellViewOutputProtocol {
    init(view: CoinsCellViewInputProtocol)
}

final class CoinsViewCell: UITableViewCell {
    
    // MARK: - Public properties
    
    var presenter: CoinsCellViewOutputProtocol!
    
    // MARK: - Private properties
    
    private lazy var coinNameLabel: UILabel = {
        let coinNameLabel = UILabel()
        coinNameLabel.text = "Bitcoin"
        coinNameLabel.textAlignment = .center
        coinNameLabel.font = UIFont.systemFont(ofSize: 25)
        return coinNameLabel
    }()
    
    private lazy var coinPriceLabel: UILabel = {
        let coinPriceLabel =  UILabel()
        coinPriceLabel.text = "16000 $"
        coinPriceLabel.textAlignment = .center
        return coinPriceLabel
    }()
    
    private lazy var changingPriceLabel: UILabel = {
        let changingPriceLabel = UILabel()
        changingPriceLabel.text = "- 0.1111 %"
        changingPriceLabel.textAlignment = .right
        return changingPriceLabel
    }()
    
    private lazy var mainStackView = UIStackView()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setStackView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setStackView() {
        let nameAndPriceStackView = UIStackView()
        
        nameAndPriceStackView.axis = .vertical
        nameAndPriceStackView.spacing = 10
        nameAndPriceStackView.distribution = .fillEqually
        
        nameAndPriceStackView.addArrangedSubview(coinNameLabel)
        nameAndPriceStackView.addArrangedSubview(coinPriceLabel)
        
        addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .horizontal
        mainStackView.spacing = 20
        mainStackView.distribution = .fillEqually
        mainStackView.addArrangedSubview(nameAndPriceStackView)
        mainStackView.addArrangedSubview(changingPriceLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
            
        ])
    }
}

extension CoinsViewCell: CoinsCellViewInputProtocol {
    
}
