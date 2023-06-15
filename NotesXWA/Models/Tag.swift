//
//  Tag.swift
//  NotesXWA
//
//  Created by Mitch Andrade on 6/15/23.
//

import Foundation
import SwiftData

@Model
class Tag {
    @Attribute(.unique) var id: String
    var name: String
    
    @Relationship var notes: [Note]
    
}
