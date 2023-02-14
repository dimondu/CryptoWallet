//
//  Coins.swift
//  CryptoWallet
//
//  Created by Дмитрий Дуров on 27.12.2022.
//

struct Coins: Decodable {
    let data: DataClass
}

struct DataClass: Decodable {
    let symbol: String?
    let name: String?
    let marketData: MarketData
}

struct MarketData: Decodable {
    let priceUsd: Double?
    let percentChangeUsdLast24Hours: Double?
}

