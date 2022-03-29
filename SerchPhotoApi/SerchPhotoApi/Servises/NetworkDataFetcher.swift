//
//  NetworkDataFetcher.swift
//  SerchPhotoApi
//
//  Created by Igor on 29.03.2022.
//

import Foundation

class NetworkDataFetcher {
    
    var networkService = NetworkService()
    
    func fetchImages(searchTerm: String, completion: @escaping (SearchResults?) -> Void) {
        networkService.request(searchTerm: searchTerm) { data, error in
            if let error = error {
                print("error \(error.localizedDescription)")
                completion(nil)
            }
            
            let decode = self.decodeJSON(type: SearchResults.self, from: data)
            completion(decode)
        }
    }
    
    func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jshonError {
            print("error json", jshonError)
            return nil
        }
    }
}
