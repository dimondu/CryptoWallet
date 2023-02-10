//
//  CoinsListViewController.swift
//  CryptoWallet
//
//  Created by Дмитрий Дуров on 26.12.2022.
//

import UIKit

protocol CoinsListViewInputProtocol: AnyObject {
    func reloadData(for section: CoinsSectionViewModel)
}

protocol CoinsListViewOutputProtocol {
    init(view: CoinsListViewInputProtocol)
    func viewDidLoad()
    func logout()
    func sortingButtonPressed()
    func didTapCell(at indexPath: IndexPath)
}

final class CoinsListViewController: UIViewController {
    
    // MARK: - Public properties
    
    var presenter: CoinsListViewOutputProtocol?
    
    // MARK: - Private properties
    
    private let configurator: CoinsListConfigurationInputProtocol = CoinsListConfiguration()
    
    private var sectionViewModel: CoinsSectionViewModelProtocol = CoinsSectionViewModel()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CoinsCell.self, forCellReuseIdentifier: "coinCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var logoutButton: UIButton = {
        let logoutButton = UIButton(type: .system)
        logoutButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        logoutButton.backgroundColor = .systemRed
        logoutButton.tintColor = .white
        logoutButton.setTitle("Log Out", for: .normal)
        logoutButton.layer.cornerRadius = 20
        logoutButton.addTarget(self, action: #selector(logOutButtonTapped), for: .touchUpInside)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        return logoutButton
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .black
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.confugure(with: self)
        addSubview()
        activityIndicator.startAnimating()
        setSortingButtom()
        setConstraints()
        setupNavigationBar()
        setupApperarance()
        presenter?.viewDidLoad()
    }
    
    // MARK: - Private methods
    
    @objc private func switchSorting() {
        presenter?.sortingButtonPressed()
    }
    
    @objc private func logOutButtonTapped() {
        presenter?.logout()
    }
    
    private func addSubview() {
        view.addSubview(tableView)
        view.addSubview(logoutButton)
        view.addSubview(activityIndicator)
    }
    
    private func setupApperarance() {
        view.backgroundColor = .white
    }
    
    private func setupNavigationBar() {
        title = "Crypto Wallet"
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = #colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1)
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func setSortingButtom() {
        let sortingBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "arrow.up.arrow.down"),
            style: .done,
            target: self,
            action: #selector(switchSorting)
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
        sectionViewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = sectionViewModel.rows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellViewModel.cellIdentifier,
                                                 for: indexPath)
        guard let cell = cell as? CoinsCell else { return UITableViewCell() }
        cell.viewModel = cellViewModel
        return cell
    }
}

// MARK: - UITableViewDelegate

extension CoinsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.didTapCell(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        sectionViewModel.rows[indexPath.row].cellHeight
    }
}

// MARK: - CoinsListViewInputProtocol

extension CoinsListViewController: CoinsListViewInputProtocol {
    func reloadData(for section: CoinsSectionViewModel) {
        sectionViewModel = section
        tableView.reloadData()
        activityIndicator.stopAnimating()
    }
}
