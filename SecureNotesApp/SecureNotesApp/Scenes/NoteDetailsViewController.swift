//
//  NoteDetailsViewController.swift
//  SecureNotesApp
//
//  Created by nika razmadze on 06.11.23.
//

import UIKit

//MARK: - Protocols
protocol NoteEditDelegate: AnyObject {
    func noteEdited(header: String, body: String, atIndex: Int)
}

final class NoteDetailsViewController: UIViewController {
    
    //MARK: - Properties
    private let headerTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .line
        textField.layer.cornerRadius = 8
        textField.layer.masksToBounds = true
        textField.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        textField.textColor = .systemGray6
        return textField
    }()
    
    private let BodyTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .line
        textField.layer.cornerRadius = 8
        textField.layer.masksToBounds = true
        textField.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        textField.textColor = .systemGray6
        textField.textAlignment = .left
        textField.contentVerticalAlignment = .top
        return textField
    }()
    
    private let saveButton = UIBarButtonItem(
        title: "Save",
        style: .plain,
        target: self,
        action: #selector(saveButtonTapped)
    )
    
    weak var delegate: NoteEditDelegate?
    var selectedIndex: Int?
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Private methods
    private func setupUI() {
        view.backgroundColor = .black
        setupTextFields()
        setupConstraints()
        setupSaveButton()
    }
    
    private func setupSaveButton() {
        navigationItem.rightBarButtonItem = saveButton
    }
    
    private func setupTextFields() {
        view.addSubview(headerTextField)
        view.addSubview(BodyTextField)
    }
    
    private func setupConstraints() {
        headerTextField.translatesAutoresizingMaskIntoConstraints = false
        BodyTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            headerTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant:  50),
            headerTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            headerTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            
            BodyTextField.topAnchor.constraint(equalTo: headerTextField.bottomAnchor, constant: 20),
            BodyTextField.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            BodyTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            BodyTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20)
        ])
    }
    
    @objc private func saveButtonTapped() {
        if let updatedHeaderText = headerTextField.text, let updatedBodyText = BodyTextField.text, let selectedIndex = selectedIndex {
            
            delegate?.noteEdited(header: updatedHeaderText, body: updatedBodyText, atIndex: selectedIndex)
            navigationController?.popViewController(animated: true)
        }
    }
    
    //MARK: - Configure
    func configure(with model: Note) {
        headerTextField.text = model.header
        BodyTextField.text = model.body
    }
    
}
