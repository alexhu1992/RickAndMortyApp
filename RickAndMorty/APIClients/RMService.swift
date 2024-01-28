//
//  RMService.swift
//  RickAndMorty
//
//  Created by Mengheng Hu on 1/7/24.
//

import Foundation

/// Primary API service object to get Rick and Morty data
final class RMService {
    
    /// Shared instance for dependency injection
    static let shared = RMService()
    
    private init() {}
    
    enum RMServerError: Error {
        case FailedToCreateRequest
        case FailedToGetData
    }
    
    public func execute<T: Codable>(
        _ request: RMRequest,
        expecting type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(RMServerError.FailedToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? RMServerError.FailedToGetData))
                return
            }
    
            do {
                let jsonResponse = try JSONDecoder().decode(type.self, from: data)
                completion(.success(jsonResponse))
            }
            catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    private func request(from rmRequest: RMRequest) -> URLRequest? {
        guard let url = rmRequest.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = rmRequest.httpMethod
        
        return request
    }
    
}
