//
//  ContentShowView.swift
//  SampleAssesmentTwo
//
//  Created by Netaxis_IOS on 08/08/25.
//
import SwiftUI
import CoreData

struct ContentShowView: View {
    let noteInformation: NoteInformation
    @State private var showFull = false
    @Environment(\.managedObjectContext) private var viewContext
    @State private var isFavorite = false
    var body: some View {
    
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(noteInformation.wrapedTitle)
                        .font(.system(size: 15, weight: .bold))
                        .font(.headline)
                    Spacer()
                    Button {
                        noteInformation.favoriteList.toggle()
                        try? viewContext.save()
                    } label: {
                        Image(systemName: "heart.fill")
                            .foregroundColor(noteInformation.favoriteList ? .red:.white)
                            .frame(width: 30, height: 30)
                            .background(Color.blue)
                            .cornerRadius(15)
                            .padding(.horizontal)
                        
                    }
                }
                
                Text(noteInformation.wrapedDescriptionData)
                    .font(.system(size: 10))
                    .lineLimit(5)
                    .multilineTextAlignment(.leading)
                //  .lineLimit(showFull ? nil : 5)
                    .onTapGesture {
                        withAnimation {
                            showFull.toggle()
                        }
                    }
                Spacer()
            }
            .frame(width: 150, height: 150)
            .padding()
            .background(Color.blue.opacity(0.2))
            .cornerRadius(15)
            .shadow(radius: 5)
            .shadow(radius: 3, x: 2, y: 2)
       
    }
}
