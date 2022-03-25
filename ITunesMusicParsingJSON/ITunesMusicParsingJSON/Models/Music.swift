//
//  Music.swift
//  ITunesMusicParsingJSON
//
//  Created by Igor on 24.03.2022.
//

import Foundation

struct Music: Codable {
    var resultCount: Int
    var results: [Track]
}

struct Track: Codable {
    var trackName: String
    var collectionName: String?
    var artistName: String
    var artworkUrl60: String?
}
