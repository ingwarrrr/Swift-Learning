//
//  NetworkService.swift
//  SerchPhotoApi
//
//  Created by Igor on 29.03.2022.
//

import Foundation

class NetworkService {
    
    // построение запросов данных по URL
    func request(searchTerm: String, completion: @escaping (Data?, Error?) -> Void) {
        
        let parameters = self.prepareParams(searchTerm: searchTerm)
        let url = self.url(params: parameters)
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeaders()
        request.httpMethod = "get"
        
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func prepareParams(searchTerm: String?) -> [String: String] {
        var params = [String: String]()
        params["query"] = searchTerm
        params["page"] = String(1)
        params["per_page"] = String(30)
        return params
    }
    
    private func url(params: [String: String]) -> URL {
        var components = URLComponents()
        // http or https
        components.scheme = "https"
        components.host = "api.unsplash.com"
        // доа знака вопроса
        components.path = "/search/photos"
        // превращаем параметры запроса в query items
        components.queryItems = params.map {
            URLQueryItem(name: $0, value: $1)
        }
        return components.url!
    }
    
    private func prepareHeaders() -> [String: String]? {
        var headers = [String: String]()
        headers["Authorization"] = "Client-ID knjyNtJ_17vlHduUi_9NIstVJ1fUvZoDMbLEcWJnWyI"
        return headers
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
}
