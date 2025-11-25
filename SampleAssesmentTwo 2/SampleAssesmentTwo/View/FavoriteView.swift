//
//  FavoriteView.swift
//  SampleAssesmentTwo
//
//  Created by Netaxis_IOS on 08/08/25.
//
import SwiftUI
import CoreData

struct FavoriteView: View {
    @State private var searchText = ""
    
    var fetchRequest: FetchRequest<NoteInformation>
        var favoriteNotes: FetchedResults<NoteInformation> { fetchRequest.wrappedValue }
        
        init(searchText: String = "") {
            if searchText.isEmpty {
                fetchRequest = FetchRequest(
                    entity: NoteInformation.entity(),
                    sortDescriptors: [],
                    predicate: NSPredicate(format: "favoriteList == true")
                )
            } else {
                fetchRequest = FetchRequest(
                    entity: NoteInformation.entity(),
                    sortDescriptors: [],
                    predicate: NSPredicate(format: "favoriteList == true AND title CONTAINS[cd] %@", searchText)
                )
            }
        }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if favoriteNotes.isEmpty {
                    Text("No matching favorites found")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 10) {
                        ForEach(favoriteNotes) { note in
                            ContentShowView(noteInformation: note)
                        }
                    }
                    .padding()
                }
            }
            .searchable(text: Binding(
                get: { searchText },
                set: { newValue in
                    searchText = newValue
                }
            ), prompt: "Search Favorites")
            .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Favorites")
                            .font(.headline)
                    }
                }

        }
    }
}
