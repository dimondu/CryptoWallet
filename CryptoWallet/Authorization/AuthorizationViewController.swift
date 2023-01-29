//
//  AuthorizationViewController.swift
//  CryptoWallet
//
//  Created by Дмитрий Дуров on 23.12.2022.
//

import UIKit

protocol AuthorizationViewInputProtocol: AnyObject {
    func showAlert()
}

protocol AuthorizationViewOutputProtocol {
    init(view: AuthorizationViewInputProtocol)
    func userLogInAccount(with login: String, password: String)
}

final class AuthorizationViewController: UIViewController {
    
    // MARK: - Public properties
    
    var presenter: AuthorizationViewOutputProtocol?
    
    // MARK: - Private properties
    
    private let configurator: AuthorizationConfigurationInputProtocol = AuthorizationConfigurator()
    
    private lazy var loginTextField: UITextField = {
        let loginTextField = UITextField()
        loginTextField.layer.cornerRadius = 10
        loginTextField.backgroundColor = .white
        loginTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10,
                                                       height: loginTextField.frame.height))
        loginTextField.leftViewMode = .always
        loginTextField.textColor = .black
        loginTextField.placeholder = "Login"
        return loginTextField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.backgroundColor = .white
        passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10,
                                                          height: passwordTextField.frame.height))
        passwordTextField.leftViewMode = .always
        passwordTextField.textColor = .black
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        return passwordTextField
    }()
    
    private lazy var logInButton: UIButton = {
        let logInButton = UIButton(type: .system)
        logInButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        logInButton.setTitle("Log In", for: .normal)
        logInButton.layer.cornerRadius = 20
        logInButton.addTarget(self, action: #selector(tapLogInButton), for: .touchUpInside)
        return logInButton
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(withView: self)
        addSubview()
        setupAppearance()
        setConstraints()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - Private methods
    
    @objc private func tapLogInButton() {
        presenter?.userLogInAccount(with: loginTextField.text ?? "",
                                    password: passwordTextField.text ?? "")
    }
    
    private func addSubview() {
        stackView.addArrangedSubview(loginTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(logInButton)
        view.addSubview(stackView)
    }
    
    private func setupAppearance() {
        view.backgroundColor = .lightGray
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                               constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                constant: -40)
        ])
    }
}

// MARK: AuthorizationViewInputProtocol

extension AuthorizationViewController: AuthorizationViewInputProtocol {
    func showAlert() {
        let alert = UIAlertController(title: "Error",
                                      message: "Please, enter correct login and password",
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel) { _ in
            self.passwordTextField.text = ""
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

