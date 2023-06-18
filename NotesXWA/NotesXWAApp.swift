//
//  NotesXWAApp.swift
//  NotesXWA
//
//  Created by Mitch Andrade on 6/15/23.
//

import SwiftUI
import SwiftData

@main
struct NotesXWAApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                noteList
                tagList
            }
            .modelContainer(for: [
                Note.self,
                Tag.self
            ])
        }
    }
    
    var noteList: some View {
        NoteListView()
    }
    
    var tagList: some View {
        TagListView()
    }
}
