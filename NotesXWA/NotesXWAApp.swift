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
            ContentView()
                .modelContainer(for: [
                    Note.self,
                    Tag.self
                ])
        }
    }
}
