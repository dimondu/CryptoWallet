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
    
    // MARK: - Public properties
    
    static let shared = NetworkManager()
    
    // MARK: - Initializers
    
    private init() {}
    
    // MARK: - Public methods
    
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
    
    func getCoins(coinNames: [String], completion: @escaping ([Coins]) -> Void) {
        let coinGroup = DispatchGroup()
        var coins: [Coins] = []
        
        for coinName in coinNames {
            coinGroup.enter()
            self.fetch(Coins.self, for: makeCoinRequest(coinName: coinName)) { result in
                switch result {
                case .success(let coin):
                    coins.append(coin)
                    coinGroup.leave()
                case .failure(let error):
                    print(error.localizedDescription)
                    coinGroup.leave()
                }
            }
        }
        coinGroup.notify(queue: .main) {
            completion(coins)
        }
    }
    
    // MARK: - Private methods
    
    private func makeCoinRequest(coinName: String) -> String {
        "https://data.messari.io/api/v1/assets/\(coinName)/metrics"
    }
}
