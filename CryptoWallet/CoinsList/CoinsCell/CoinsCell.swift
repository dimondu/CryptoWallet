//
//  CoinsCell.swift
//  CryptoWallet
//
//  Created by Дмитрий Дуров on 17.01.2023.
//

import UIKit

protocol CellModelRepresentable {
    var viewModel: CoinsCellViewModelProtocol? { get }
}

final class CoinsCell: UITableViewCell, CellModelRepresentable {
    
    // MARK: - Public properties
    
    var viewModel: CoinsCellViewModelProtocol? {
        didSet {
            updateView()
        }
    }
    
    // MARK: - Private properties
    
    private let coinNameLabel: UILabel = {
        let coinNameLabel = UILabel()
        coinNameLabel.textAlignment = .center
        coinNameLabel.font = UIFont.systemFont(ofSize: 25)
        return coinNameLabel
    }()
    
    private let coinPriceLabel: UILabel = {
        let coinPriceLabel =  UILabel()
        coinPriceLabel.textAlignment = .center
        return coinPriceLabel
    }()
    
    private let changingPriceLabel: UILabel = {
        let changingPriceLabel = UILabel()
        changingPriceLabel.textAlignment = .right
        return changingPriceLabel
    }()
    
    private let mainStackView: UIStackView = {
        let mainStackView = UIStackView()
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .horizontal
        mainStackView.spacing = 20
        mainStackView.distribution = .fillEqually
        return mainStackView
    }()
    
    private let nameAndPriceStackView: UIStackView = {
        let nameAndPriceStackView = UIStackView()
        nameAndPriceStackView.axis = .vertical
        nameAndPriceStackView.spacing = 10
        nameAndPriceStackView.distribution = .fillEqually
        return nameAndPriceStackView
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func updateView() {
        guard let viewModel = viewModel as? CoinsCellViewModel else { return }
        coinNameLabel.text = viewModel.coinName
        coinPriceLabel.text = String(format: "%.3f" , viewModel.coinPrice) + "$"
        changingPriceLabel.text = String(format: "%.3f", viewModel.coinPriceChainging) + "%"
    }
    
    private func addSubview() {
        nameAndPriceStackView.addArrangedSubview(coinNameLabel)
        nameAndPriceStackView.addArrangedSubview(coinPriceLabel)
        
        mainStackView.addArrangedSubview(nameAndPriceStackView)
        mainStackView.addArrangedSubview(changingPriceLabel)
        
        addSubview(mainStackView)
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

