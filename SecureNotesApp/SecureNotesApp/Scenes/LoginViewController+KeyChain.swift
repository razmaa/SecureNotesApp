//
//  LoginViewController+KeyChain.swift
//  SecureNotesApp
//
//  Created by nika razmadze on 05.11.23.
//

import UIKit
import Security

extension LoginViewController {
    
    
    func saveFirstTimeLogin() {
        UserDefaults.standard.set(false, forKey: "FirstTimeLogin")
        UserDefaults.standard.synchronize()
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(
            title: "Welcome",
            message: message,
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(
            title: "OK",
            style: .default,
            handler: { [weak self] action in self?.navigationController?.pushViewController(NoteListViewController(), animated: true) }
        )
        
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
        
    }
    
    
    func saveToKeychain(service: String, key: String, data: Data) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        
        SecItemDelete(query as CFDictionary)
        let status = SecItemAdd(query as CFDictionary, nil)
        
        return status == errSecSuccess
    }
    
    func loadFromKeychain(service: String, key: String) -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var data: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &data)
        
        if status == errSecSuccess {
            return data as? Data
        } else {
            return nil
        }
    }
    
    func loadUsernameFromKeychain() -> String? {
        let service = "NotesAppService"
        let usernameKey = "Username"
        
        if let usernameData = loadFromKeychain(service: service, key: usernameKey), let username = String(data: usernameData, encoding: .utf8) {
            return username
        }
        
        return nil
    }
    
    func loadPasswordFromKeychain() -> String? {
        let service = "NotesAppService"
        let passwordKey = "Password"
        
        if let passwordData = loadFromKeychain(service: service, key: passwordKey), let password = String(data: passwordData, encoding: .utf8) {
            return password
        }
    
        return nil
    }
    
    func saveUsernameAndPasswordToKeychain(username: String, password: String) -> Bool {
        let service = "NotesAppService"
        let usernameKey = "Username"
        let passwordKey = "Password"
        
        if let usernameData = username.data(using: .utf8), let passwordData = password.data(using: .utf8) {
            if saveToKeychain(service: service, key: usernameKey, data: usernameData) {
                if saveToKeychain(service: service, key: passwordKey, data: passwordData) {
                    return true
                }
            }
        }
        return false
    }
}
