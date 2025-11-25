//
//  File.swift
//  SampleAssesmentTwo
//
//  Created by Netaxis_IOS on 08/08/25.
//
import Foundation
import CoreData

class DataManager {
    let container = NSPersistentContainer(name: "NoteDataModel")
    static let shared = DataManager()
    
    static var sharedPreview: DataManager = {
        let manager = DataManager(inMemory: true)
        let previewNote = NoteInformation(context: manager.container.viewContext)
        previewNote.id = UUID()
        previewNote.title = "Sample Note"
        previewNote.descriptionData = "This is a preview note for testing."
        previewNote.favoriteList = true
        try? manager.container.viewContext.save()
        return manager
    }()
    
    private init(inMemory: Bool = false) {
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
