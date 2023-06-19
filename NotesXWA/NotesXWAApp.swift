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
        NavigationStack {
            NoteListView()
                .navigationTitle("Notes")
        }
        .tabItem { Label("Notes", systemImage: "note") }
    }
    
    var tagList: some View {
        NavigationStack {
            TagListView()
                .navigationTitle("Tags")
        }
        .tabItem { Label("Tags", systemImage: "tag") }
    }
}
