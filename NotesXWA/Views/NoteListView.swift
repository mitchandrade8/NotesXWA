//
//  NoteListView.swift
//  NotesXWA
//
//  Created by Mitch Andrade on 6/15/23.
//

import SwiftUI
import SwiftData

struct NoteListView: View {
    
    @Environment(\.modelContext) private var context
    @Query(sort: \.createdAt, order: .reverse) var allNotes: [Note]
    @State var noteText = ""
    
    var body: some View {
        List {
            Section {
                DisclosureGroup("Create a note") {
                    TextField("Enter text", text: $noteText, axis: .vertical)
                        .lineLimit(2...4)
                    
                    Button("Save") {
                        createNote()
                    }
                }
            }
            
            Section {
                if allNotes.isEmpty {
                    ContentUnavailableView("You do not have any notes yet.", systemImage: "note")
                } else {
                    ForEach(allNotes) { note in
                        VStack(alignment: .leading) {
                            Text(note.content)
                            Text(note.createdAt, style: .time)
                                .font(.subheadline)
                        }
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            context.delete(allNotes[index])
                        }
                        try? context.save()
                    }
                }
            }
        }
    }
    
    func createNote() {
        let note = Note(id: UUID().uuidString, content: noteText, createdAt: .now, tags: [])
        context.insert(note)
         try? context.save()
    }
}

#Preview {
    NoteListView()
}
