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
    @Query(sort: \.name, order: .forward) var allTags: [Tag]
    @State var noteText = ""
    
    var body: some View {
        List {
            Section {
                DisclosureGroup("Create a note") {
                    TextField("Enter text", text: $noteText, axis: .vertical)
                        .lineLimit(2...4)
                    
                    DisclosureGroup("Tag With") {
                        if allTags.isEmpty {
                            Text("You do not have any tags yet. Please create one from Tags tab")
                                .foregroundStyle(Color.gray)
                        }
                        
                        ForEach(allTags) { tag in
                            HStack {
                                Text(tag.name)
                                if tag.isChecked {
                                    Spacer()
                                    Image(systemName: "checkmark.circle")
                                        .symbolRenderingMode(.multicolor)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                tag.isChecked.toggle()
                            }
                        }
                    }
                    
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
                            if note.tags.count > 0 {
                                Text("Tags:" + note.tags.map { $0.name }.joined(separator: ", "))
                                    .font(.caption)
                            }
                            Text(note.createdAt, style: .time)
                                .font(.subheadline)
                        }
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            context.delete(allNotes[index])
                        }
                        try? context.save()
                        noteText = ""
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
