//
//  ViewController.swift
//  SecureNotesApp
//
//  Created by nika razmadze on 05.11.23.
//

import UIKit
import Security

class LoginViewController: UIViewController  {
    
    //MARK: - Properties
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 15
        return stackView
    }()
    
    private let userNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.placeholder = "Username"
        textField.layer.cornerRadius = 8
        textField.layer.masksToBounds = true
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.placeholder = "Password"
        textField.layer.cornerRadius = 8
        textField.layer.masksToBounds = true
        return textField
    }()
    
    private let logInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Private Methods
    private func setupUI() {
        view.backgroundColor = .black
        title = "Notes"
        setupStackView()
        setupConstraints()
        setupAction()
    }
    
    private func setupStackView() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(userNameTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(logInButton)
    }
    
    private func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 300)
        ])
        userNameTextField.setContentHuggingPriority(.required, for: .vertical)
        passwordTextField.setContentHuggingPriority(.required, for: .vertical)
        logInButton.setContentHuggingPriority(.required, for: .vertical)
    }
    
    private func setupAction() {
        
        UserDefaults.standard.set(true, forKey: "isFirstTimeLogin")
        
        logInButton.addAction(UIAction(
            handler: { [weak self] action in
                self?.actionForLoginButton()
            }), for: .touchUpInside)
    }
    
    
    private func actionForLoginButton() {
        guard let username = userNameTextField.text, !username.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            userNameTextField.backgroundColor = .red
            passwordTextField.backgroundColor = .red
            return
        }
        
        if let savedUsername = loadUsernameFromKeychain(), let savedPassword = loadPasswordFromKeychain() {
            if username == savedUsername && password == savedPassword {
                showAlert(message: "Welcome back!")
            } else {
                if saveUsernameAndPasswordToKeychain(username: username, password: password) {
                    saveFirstTimeLogin()
                    showAlert(message: "Welcome to our app! You've just logged in for the first time.")
                }
            }
        }
    }
    
}


