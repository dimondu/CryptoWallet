//
//  Coins.swift
//  CryptoWallet
//
//  Created by Дмитрий Дуров on 27.12.2022.
//

let coins = ["btc", "eth", "tron", "luna", "polkadot", "dogecoin", "tether", "stellar", "cardano", "xrp"]

struct Coins: Decodable {
    let data: DataClass
}

struct DataClass: Decodable {
    let symbol: String
    let name: String
    let marketData: MarketData
}

struct MarketData: Decodable {
    let priceUsd: Double
    let percentChangeUsdLast24_Hours: Double
}

