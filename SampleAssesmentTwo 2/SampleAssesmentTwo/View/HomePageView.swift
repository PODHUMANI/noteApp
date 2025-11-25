////
////  HomePageView.swift
////  SampleAssesmentTwo
////
////  Created by Netaxis_IOS on 08/08/25.
////
//
import SwiftUI
import CoreData

struct HomePageView: View {
    @State private var searchText = ""
    @State private var selectedNote: NoteInformation?
    @FetchRequest(entity: NoteInformation.entity(), sortDescriptors: []) var notes: FetchedResults<NoteInformation>
    @Environment(\.managedObjectContext) private var viewContext
    
    var filteredNotes: [NoteInformation] {
        if searchText.isEmpty {
            return Array(notes)
        } else {
            return notes.filter { $0.wrapedTitle.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if notes.isEmpty {
                    VStack {
                        NavigationLink {
                            ContentAddView()
                        } label: {
                            Text("+")
                                .font(.system(size: 130, weight: .bold))
                                .foregroundColor(.white)
                                .frame(width: 200, height: 200)
                                .background(Color.blue.opacity(0.3))
                                .cornerRadius(30)
                        }
                    }
                } else {
                    ScrollView {
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 20) {
                            
                            // Add New Note Button
                            NavigationLink {
                                ContentAddView()
                            } label: {
                                Text("+")
                                    .font(.system(size: 100, weight: .bold))
                                    .foregroundColor(.white)
                                    .frame(width: 150, height: 150)
                                    .background(Color.blue.opacity(0.3))
                                    .cornerRadius(30)
                            }
                            
                            // All Notes
                            ForEach(filteredNotes) { item in
                                Button {
                                    selectedNote = item
                                } label: {
                                    ContentShowView(noteInformation: item)
                                        .foregroundStyle(.black)
                                }
                                .contextMenu {
                                    Button(role: .destructive) {
                                        delete(note: item)
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search Notes")
            .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("My Notes")
                            .font(.headline)
                    }
                }
            .navigationDestination(item: $selectedNote) { item in
                ContentAddView(noteInformation: item)
            }
        }
    }
    
    private func delete(note: NoteInformation) {
        viewContext.delete(note)
        try? viewContext.save()
    }
}

#Preview {
    let dataManager = DataManager.sharedPreview
    return HomePageView()
        .environment(\.managedObjectContext, dataManager.container.viewContext)
}
