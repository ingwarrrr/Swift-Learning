//
//  ContentAPI.swift
//  DesignCodeApp
//
//  Created by Tiago Mergulhão on 27/03/18.
//  Copyright © 2018 Meng To. All rights reserved.
//

import RealmSwift

class Bookmark : Object, Decodable {

    @objc dynamic var section : Section?
    @objc dynamic var sectionId : String = ""

    @objc dynamic var part : Part?
    @objc dynamic var partId : String = ""
}

class Section : Object, Decodable {

    @objc dynamic var id : String = ""
    @objc dynamic var title : String = ""
    @objc dynamic var caption : String = ""
    @objc dynamic var body : String = ""
    @objc dynamic var imageName : String = ""
    @objc dynamic var chapterNumber : String = ""

    @objc dynamic var publishDate : Date?

    var parts : List<Part> = List<Part>()

    private enum CodingKeys : String, CodingKey {
        case id, title, caption, body, imageName, chapterNumber, publishDate, parts
    }

    override static func primaryKey() -> String? { return "id" }

    convenience required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.init()

        id = try container.decode(String.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        caption = try container.decode(String.self, forKey: .caption)
        body = try container.decode(String.self, forKey: .body)
        imageName = try container.decode(String.self, forKey: .imageName)
        chapterNumber = try container.decode(String.self, forKey: .chapterNumber)

        publishDate = try container.decode(Date.self, forKey: .publishDate)

        parts = List<Part>()
    }
}

extension List : Decodable {
    public convenience init(from decoder: Decoder) throws {
        self.init()
    }
}

enum PartType : String {
    case text, image, video, code
}

class Part : Object, Decodable {

    @objc dynamic var id : String = ""
    @objc dynamic var title : String = ""
    @objc dynamic var content : String = ""

    @objc dynamic var typeName : String = ""

    @objc dynamic var section : Section?

    override static func primaryKey() -> String? { return "id" }

    var type : PartType? { return PartType(rawValue: typeName) }

    enum CodingKeys : String, CodingKey {
        case content, id, title
        case typeName = "type"
    }
}

class ContentAPI {

    static var shared : ContentAPI = ContentAPI()

    lazy var bookmarks : Array<Bookmark> = {
        return load(into: Array<Bookmark>.self, resource: "Bookmarks") ?? []
    }()

    lazy var parts : Array<Part> = {
        return load(into: Array<Part>.self, resource: "Parts") ?? []
    }()

    lazy var sections : Array<Section> = {
        return load(into: Array<Section>.self, resource: "Sections") ?? []
    }()

    func load<T : Decodable>(into swiftType : T.Type, resource : String, ofType type : String = "json") -> T? {

        let path = Bundle.main.path(forResource: resource, ofType: type)
        let url = URL(fileURLWithPath: path!)

        guard let data = try? Data(contentsOf: url) else { return nil }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .secondsSince1970

        return try! decoder.decode(swiftType.self, from: data)
    }
}
