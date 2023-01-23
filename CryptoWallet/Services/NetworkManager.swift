//
//  NetworkManager.swift
//  CryptoWallet
//
//  Created by Дмитрий Дуров on 12.01.2023.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private let coinNames = ["btc", "eth", "tron", "luna", "polkadot", "dogecoin", "tether", "stellar", "cardano", "xrp"]
    private var apiLinks: [String] = []
    
    private init() {}
    
    func fetch<T: Decodable>(_ type: T.Type,  for url: String?, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let urlString = url, let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No Description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let type = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(type))
                }
            } catch {
                completion(.failure(.decodingError))
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func getCoins(completion: @escaping ([Coins]) -> Void) {
        let coinGroup = DispatchGroup()
        var coins: [Coins] = []
        getLinks()
        
        for link in self.apiLinks {
            coinGroup.enter()
            self.fetch(Coins.self, for: link) { result in
                switch result {
                case .success(let coin):
                    coins.append(coin)
                    coinGroup.leave()
                case .failure(let error):
                    print("\(error.localizedDescription) \(link)")
                    coinGroup.leave()
                }
            }
        }
        coinGroup.notify(queue: .main) {
            completion(coins)
        }
    }
    
    private func getLinks() {
        for coinName in coinNames {
            let url = "https://data.messari.io/api/v1/assets/" + coinName + "/metrics"
            apiLinks.append(url)
        }
    }
}
