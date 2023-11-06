//
//  NotesTableViewCell.swift
//  SecureNotesApp
//
//  Created by nika razmadze on 05.11.23.
//

import UIKit

class NotesTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    private let cellStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        return stackView
    }()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        return label
    }()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray6
        return label
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PrepareForReuse
    override func prepareForReuse() {
        super.prepareForReuse()
        headerLabel.text = nil
        bodyLabel.text = nil
    }
    
    // MARK: - Configure
    func configure(with model: Note) {
        headerLabel.text = model.header
        bodyLabel.text = model.body
    }
    
    //MARK: - Private Methods
    private func setupUI() {
        backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        setupStackView()
        setUpCells()
        setUpConstraints()
    }
    private func setupStackView() {
        addSubview(cellStackView)
        cellStackView.addArrangedSubview(headerLabel)
        cellStackView.addArrangedSubview(bodyLabel)
    }
    
    private func setUpCells() {
        layer.shadowColor = UIColor.white.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
    }
    
    private func setUpConstraints() {
        cellStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 14),
            cellStackView.leftAnchor.constraint(equalTo: self.leftAnchor),
            cellStackView.rightAnchor.constraint(equalTo: self.rightAnchor),
            cellStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
