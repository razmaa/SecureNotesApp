//
//  NoteModel.swift
//  SecureNotesApp
//
//  Created by nika razmadze on 05.11.23.
//

import UIKit

class Note {
    var header: String
    var body: String
    
    init(header: String, body: String) {
        self.header = header
        self.body = body
    }
}
