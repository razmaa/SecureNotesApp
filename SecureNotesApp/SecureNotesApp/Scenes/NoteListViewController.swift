//
//  NoteListViewController.swift
//  SecureNotesApp
//
//  Created by nika razmadze on 05.11.23.
//

import UIKit

//ეს არ ვიცი რამდენად მისაღებია აქ რო წერია
var allNotes: [Note] = [
    Note(header: "Hello World", body: "Hi"),
    Note(header: "Hello World", body: "Hi"),
    Note(header: "Hello World", body: "Hi")
]

class NoteListViewController: UIViewController {
    
    //MARK: - Properties
    private let notesTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        tableView.layer.cornerRadius = 12
        tableView.clipsToBounds = true
        return tableView
    }()
    
    private var plusButton: UIBarButtonItem!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        notesTableView.reloadData()
    }
    
    //MARK: - Private Methods
    private func setupUI() {
        view.backgroundColor = .black
        setupBarButton()
        setupTableView()
        setupConstraints()
    }
    
    private func setupBarButton() {
        plusButton = UIBarButtonItem(image: UIImage(systemName: "plus.circle.fill"), style: .plain, target: self, action: #selector(plusButtonTapped))
        navigationItem.rightBarButtonItem = plusButton
    }
    
    private func setupTableView() {
        view.addSubview(notesTableView)
        notesTableView.register(NotesTableViewCell.self, forCellReuseIdentifier: "noteCell")
        notesTableView.dataSource = self
        notesTableView.delegate = self
    }
    
    private func setupConstraints() {
        notesTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            notesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            notesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            notesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            notesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    @objc private func plusButtonTapped() {
        let addNoteViewController = AddNoteViewController()
        navigationController?.pushViewController(addNoteViewController, animated: true)
    }
}

//MARK: - TableView DataSource
extension NoteListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allNotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let note = allNotes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        if let noteCell = cell as? NotesTableViewCell {
            noteCell.configure(with: note)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let noteToDelete = allNotes[indexPath.row]
            if let index = allNotes.firstIndex(where: { $0 === noteToDelete }) {
                allNotes.remove(at: index)
            }
        }
        
        notesTableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
}


//MARK: - TableView Delegate
extension NoteListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedNote = allNotes[indexPath.row]
        let selectedIndex = indexPath.row
        let noteDetailsViewController = NoteDetailsViewController()
        noteDetailsViewController.configure(with: selectedNote)
        noteDetailsViewController.selectedIndex = selectedIndex
        noteDetailsViewController.delegate = self
        navigationController?.pushViewController(noteDetailsViewController, animated: true)
    }
}

//MARK: - NoteEdit Delegate
extension NoteListViewController: NoteEditDelegate {
    func noteEdited(header: String, body: String, atIndex: Int) {
        allNotes[atIndex].header = header
        allNotes[atIndex].body = body
        notesTableView.reloadData()
    }
}
