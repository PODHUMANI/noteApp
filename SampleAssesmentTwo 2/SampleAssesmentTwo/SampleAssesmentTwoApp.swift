//
//  SampleAssesmentTwoApp.swift
//  SampleAssesmentTwo
//
//  Created by Netaxis_IOS on 08/08/25.
//

import SwiftUI

@main
struct SampleAssesmentTwoApp: App {
    let dataManager = DataManager.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment( \.managedObjectContext,dataManager.container.viewContext)

        }
    }
}
