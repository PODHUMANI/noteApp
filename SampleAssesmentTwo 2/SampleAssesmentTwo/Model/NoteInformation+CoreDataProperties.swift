//
//  NoteInformation+CoreDataProperties.swift
//  SampleAssesmentTwo
//
//  Created by Netaxis_IOS on 08/08/25.
//
//
import Foundation
import CoreData

extension NoteInformation {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteInformation> {
        return NSFetchRequest<NoteInformation>(entityName: "NoteInformation")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var descriptionData: String?
    @NSManaged public var favoriteList: Bool
}

extension NoteInformation: Identifiable { }

extension NoteInformation {
    var wrapedTitle: String { title ?? "" }
    var wrapedDescriptionData: String { descriptionData ?? "" }
    var wrapedFavoriteList: Bool { favoriteList }
}
