//
//  CoinsListViewController.swift
//  CryptoWallet
//
//  Created by Дмитрий Дуров on 26.12.2022.
//

import UIKit

protocol CoinsListViewInputProtocol: AnyObject {
    
}

protocol CoinsListViewOutputProtocol {
    init(view: CoinsListViewInputProtocol)
    func logout()
}

final class CoinsListViewController: UIViewController {
    
    // MARK: - Public properties
    
    var presenter: CoinsListViewOutputProtocol!
    
    // MARK: - Private properties
    
    private let configurator: CoinsListConfigutationInputProtocol = CoinsListConfiguration()
    
    private var ascendingSorting = true
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CoinsViewCell.self, forCellReuseIdentifier: "coinCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var logoutButton: LogOutButton = {
        let logOutButton = LogOutButton(type: .system)
        logOutButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        logOutButton.addTarget(self, action: #selector(logOutButtonTapped), for: .touchUpInside)
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        return logOutButton
    }()
    
    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Crypto Wallet"
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(logoutButton)
        
        configurator.confugure(with: self)
        setSortingButtom()
        setConstraints()
    }
    
    // MARK: - Public methods
    
    @objc func sortingButtonTapped() {
        if ascendingSorting {
            ascendingSorting.toggle()
            print("По убыванию")
        } else {
            ascendingSorting.toggle()
            print("По возрастанию")
        }
    }
    
    @objc func logOutButtonTapped() {
        presenter.logout()
    }
    
    // MARK: - Private methods
    
    private func setSortingButtom() {
        let sortingBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "arrow.up.arrow.down"),
            style: .done,
            target: self,
            action: #selector(sortingButtonTapped)
        )
        navigationItem.leftBarButtonItem = sortingBarButtonItem
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            logoutButton.widthAnchor.constraint(equalToConstant: 150),
            logoutButton.heightAnchor.constraint(equalToConstant: 50),
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: logoutButton.topAnchor, constant: -20)
        ])
    }
}

// MARK: - UITableViewDataSource

extension CoinsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "coinCell", for: indexPath)
                as? CoinsViewCell
        else {
            return UITableViewCell()
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension CoinsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - CoinsListViewInputProtocol

extension CoinsListViewController: CoinsListViewInputProtocol {
    
}
