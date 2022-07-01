//
//  CoreDataManager.swift
//  DesignCodeApp
//
//  Created by Tiago Mergulhão on 04/04/18.
//  Copyright © 2018 Meng To. All rights reserved.
//

import CoreData

extension Section {

    func configure(with codable : SectionCodable) {

        body = codable.body
        caption = codable.caption
        chapterNumber = codable.chapterNumber
        id = codable.id
        imageName = codable.imageName
        title = codable.title
        publishDate = codable.publishDate
    }
}

extension Part {

    func configure(with codable : PartCodable) {

        content = codable.content
        id = codable.id
        title = codable.title
        type = codable.typeName
    }
}

extension NSEntityDescription {

    static func object<T : NSManagedObject>(into context : NSManagedObjectContext) -> T {

        return insertNewObject(forEntityName: String(describing: T.self), into: context) as! T
    }
}

class CoreDataManager {

    static let shared = CoreDataManager()

    func loadFromData () {

        let contentAPI = ContentAPI.shared

        let bookmarksCodable = contentAPI.bookmarks
        let sectionsCodable = contentAPI.sections
        let partsCodable = contentAPI.parts

        // Parsing sections

        for sectionCodable in sectionsCodable {

            let section : Section = NSEntityDescription.object(into: context)

            section.configure(with: sectionCodable)

            // Saving the possible bookmarks

            let bookmarksForThisSection = bookmarksCodable.filter { $0.sectionId == sectionCodable.id }

            // Parsing the parts

            for partCodable in partsCodable {

                let part : Part = NSEntityDescription.object(into: context)

                part.configure(with: partCodable)

                section.addToParts(part)

                // Creating the bookmark

                for candidate in bookmarksForThisSection {

                    if candidate.partId == partCodable.id {

                        let bookmark : Bookmark = NSEntityDescription.object(into: context)

                        bookmark.part = part

                        break
                    }
                }
            }
        }

        saveContext()
    }

    func remove(_ bookmark : Bookmark) {

        context.delete(bookmark)
        saveContext()

        bookmarks = fetch(entityName: "Bookmark", ofType: Bookmark.self) ?? []
    }

    lazy var bookmarks : Array<Bookmark> = fetch(entityName: "Bookmark", ofType: Bookmark.self) ?? []

    lazy var sections : Array<Section> = fetch(entityName: "Section", ofType: Section.self) ?? []

    func fetch<T : NSFetchRequestResult>(entityName : String, ofType coreDataType : T.Type) -> Array<T>? {

        do {
            let entities = try context.fetch(NSFetchRequest<T>(entityName: entityName))
            return entities
        } catch {
            print(error)
        }

        return []
    }

    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    var context : NSManagedObjectContext { return persistentContainer.viewContext }

    func saveContext () {

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
