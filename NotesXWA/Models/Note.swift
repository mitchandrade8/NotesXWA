//
//  Note.swift
//  NotesXWA
//
//  Created by Mitch Andrade on 6/15/23.
//

import Foundation
import SwiftData

@Model
class Note {
    @Attribute(.unique) var id: String
    var content: String
    var createdAt: Date
    
    init(id: String, content: String, createdAt: Date) {
        self.id = id
        self.content = content
        self.createdAt = createdAt
    }
}
