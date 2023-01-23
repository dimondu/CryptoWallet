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
    
    private let configurator: CoinsListConfigutationInputProtocol = CoinsListConfiguration()
    private var activityIndicator: UIActivityIndicatorView?
    private var sectionViewModel: CoinsSectionViewModelProtocol = CoinsSectionViewModel()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CoinsCell.self, forCellReuseIdentifier: "coinCell")
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
        activityIndicator = showActivityIndicator(in: view)
        
        configurator.confugure(with: self)
        setSortingButtom()
        setConstraints()
        setupNavigationBar()
        presenter?.viewDidLoad()
    }
    
    // MARK: - Public methods
    
    @objc func switchSorting() {
        presenter?.sortingButtonPressed()
    }
    
    @objc func logOutButtonTapped() {
        presenter?.logout()
    }
    
    // MARK: - Private methods
    
    private func setupNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = #colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1)
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    private func showActivityIndicator(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .black
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
        
        return activityIndicator
    }
    
    private func setSortingButtom() {
        let sortingBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "arrow.up.arrow.down"),
            style: .done,
            target: self,
            action: #selector(switchSorting)
        )
        sortingBarButtonItem.tintColor = .white
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
        activityIndicator?.stopAnimating()
    }
    
    
}
