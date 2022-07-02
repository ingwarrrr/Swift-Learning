//
//  RealmManager.swift
//  DesignCodeApp
//
//  Created by Tiago Mergulhão on 11/04/18.
//  Copyright © 2018 Meng To. All rights reserved.
//

import RealmSwift

class RealmManager {

    static var realm = try! Realm()

    static var bookmarks : Results<Bookmark> { return realm.objects(Bookmark.self) }

    static var sections : Results<Section> { return realm.objects(Section.self) }

    class func remove(_ bookmark : Bookmark) {

        try! realm.write { realm.delete(bookmark) }
    }

    class func loadFromData () {

        let contentAPI = ContentAPI.shared

        let bookmarks = contentAPI.bookmarks
        let sections = contentAPI.sections
        let parts = contentAPI.parts

        sections.forEach { $0.parts.append(objectsIn: parts) }

        bookmarks.forEach { (bookmark) in
            bookmark.section = sections
                .filter { $0.id == bookmark.sectionId }
                .first
            bookmark.part = parts
                .filter { $0.id == bookmark.partId }
                .first
        }

        try! realm.write { realm.add(sections, update: true) }

        try! realm.write { realm.add(bookmarks) }
    }
}
