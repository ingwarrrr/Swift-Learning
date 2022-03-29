//
//  SearchResults.swift
//  SerchPhotoApi
//
//  Created by Igor on 29.03.2022.
//

import Foundation

struct SearchResults: Codable {
    let total: Int
    let results: [UnsplashPhoto]
}

struct UnsplashPhoto: Codable {
    let width: Int
    let height: Int
    let urls: [URLKing.RawValue: String]
    
    enum URLKing: String {
        case raw
        case full
        case regular
        case small
        case thumb
    }
}
