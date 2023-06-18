//
//  TagListView.swift
//  NotesXWA
//
//  Created by Mitch Andrade on 6/15/23.
//

import SwiftUI
import SwiftData

struct TagListView: View {
    
    @Environment(\.modelContext) private var context
    @Query(sort: \.name, order: .forward) var allTags: [Tag]
    @State var tagText = ""
    
    var body: some View {
        List {
            Section {
                DisclosureGroup("Create a tag") {
                    TextField("Enter text", text: $tagText, axis: .vertical)
                        .lineLimit(2...4)
                    
                    Button("Save") {
                        createTag()
                    }
                }
            }
            
            Section {
                if allTags.isEmpty {
                    ContentUnavailableView("You do not have any tags yet.", systemImage: "tag")
                } else {
                    ForEach(allTags) { tag in
                        VStack(alignment: .leading) {
                            Text(tag.name)
                        }
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            context.delete(allTags[index])
                        }
                        try? context.save()
                    }
                }
            }
        }
    }
    
    func createTag() {
        let tag = Tag(id: UUID().uuidString, name: tagText, notes: [])
        context.insert(tag)
        try? context.save()
    }
}

#Preview {
    TagListView()
}
