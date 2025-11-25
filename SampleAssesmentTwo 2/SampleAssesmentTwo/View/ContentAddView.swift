//
//  ContentAddView.swift
//  SampleAssesmentTwo
//
//  Created by Netaxis_IOS on 08/08/25.
//
import SwiftUI
import CoreData

struct ContentAddView: View {
    @State private var title = ""
    @State private var descriptionText = ""
    @State private var isFavorite = false
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    
    var noteInformation: NoteInformation?
//    @State private var alertTitle = ""
//    @State private var alertMessage = ""
//    @State private var showAlert = false
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text(noteInformation == nil ? "Add New Note" : "Edit Note")
                    .font(.system(size: 30, weight: .bold))
                Spacer()
                Button {
                    isFavorite.toggle()
                } label: {
                    Image(systemName: "heart.fill")
                        .foregroundColor(isFavorite ? .red:.white)
                        .frame(width: 30, height: 30)
                        .background(Color.blue)
                        .cornerRadius(15)
                        .padding(.horizontal)
                }
            }
            
            Text("Title:")
            TextField("Enter Title", text: $title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            Text("Description:")
            TextEditor(text: $descriptionText)
                .frame(maxWidth: .infinity, maxHeight: 300)
                .border(Color.gray)
                .padding(.horizontal)
            
            HStack {
                Spacer()
                Button {
                    if let note = noteInformation {
                        note.title = title
                        note.descriptionData = descriptionText
                        note.favoriteList = isFavorite
                        do{
                            try viewContext.save()
                        }catch {
                            return
                        }
                    } else {
                        let newNote = NoteInformation(context: viewContext)
                        newNote.id = UUID()
                        newNote.title = title
                        newNote.descriptionData = descriptionText
                        newNote.favoriteList = isFavorite
                            do{
                                try viewContext.save()
                            }catch {
                                return
                            }                    }
                    dismiss()
                } label: {
                    Text(noteInformation == nil ? "Add Note" : "Update Note")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding(8)
                        .background(Color.blue)
                        .cornerRadius(15)
                        .shadow(radius: 3)
                }
                .padding(.top)
            }
        }
//        .alert(alertTitle, isPresented: $showAlert){
//            Button(action: {
//                
//            }, label: {
//                Text("OK")
//            })
//        }message: {
//            Text(alertMessage)
//        }
        .padding()
        .onAppear(perform: {
            if let note = noteInformation {
                title = note.wrapedTitle
                descriptionText = note.wrapedDescriptionData
                isFavorite = note.wrapedFavoriteList
            }
        })
    }
}
