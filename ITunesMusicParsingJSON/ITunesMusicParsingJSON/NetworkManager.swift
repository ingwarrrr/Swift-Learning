//
//  NetworkManager.swift
//  ITunesMusicParsingJSON
//
//  Created by Igor on 25.03.2022.
//

import Foundation

class NetworkManager {
    func request(urlSrt: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlSrt) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    return
                }
                
                completion(.success(data))
            }
        }.resume()
    }
}
