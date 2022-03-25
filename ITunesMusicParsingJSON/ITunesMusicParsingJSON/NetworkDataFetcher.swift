//
//  NetworkDataFetcher.swift
//  ITunesMusicParsingJSON
//
//  Created by Igor on 25.03.2022.
//

import Foundation

class NetworkDataFetcher {
    let networkManager = NetworkManager()
    
    func fetchTracks(urlStr: String, response: @escaping (Music?) -> Void) {
        networkManager.request(urlSrt: urlStr) { result in
            switch result {
            case .success(let data):
                do {
                    let tracks = try JSONDecoder().decode(Music.self, from: data)
                    response(tracks)
                } catch let jsonError {
                    print("failed to decode JSON", jsonError)
                    response(nil)
                }
            case .failure(let error):
                print("failed to request data", error)
                response(nil)
                
            }
        }
    }
}
