//
//  ContentView.swift
//  SampleAssesmentTwo
//
//  Created by Netaxis_IOS on 08/08/25.
//
import SwiftUI

struct ContentView: View {
    @State private var isActive: Bool = false
    @Environment(\.managedObjectContext) private var viewContext
    var body: some View {
        NavigationStack {
            TabView {
                if isActive {
                    
                    HomePageView()
                        .tabItem {
                            Label("Home", systemImage: "house.fill")
                        }
                
                FavoriteView()
                    .tabItem {
                        Label("Favorite", systemImage: "heart.fill")
                    }
            } else {
                ZStack {
                    Color.white.ignoresSafeArea()
                    VStack {
                        Image(systemName: "heart.text.clipboard")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.blue)
                        Text("Welcome \n To\n NoteApp")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.blue)
                            .font(.title)
                            .padding()
                    }
                }
            }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    
    let dataManager = DataManager.sharedPreview
  return  ContentView().environment(\.managedObjectContext, dataManager.container.viewContext)
}
