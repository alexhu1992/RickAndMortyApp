//
//  RMRequest.swift
//  RickAndMorty
//
//  Created by Mengheng Hu on 1/7/24.
//

import Foundation

final class RMRequest {
    
    private struct Constant {
        static let baseUrl = "https://rickandmortyapi.com/api"
    }
    
    let endpoint: RMEndpoint
    let pathComponents: [String]
    let queryParams: [URLQueryItem]
    
    private var urlString: String {
        var string = Constant.baseUrl
        string += "/"
        string += endpoint.rawValue
        
        if !pathComponents.isEmpty {
            pathComponents.forEach({
                string += "/\($0)"
            })
        }
        
        if !queryParams.isEmpty {
            string += "?"
            let argumentString = queryParams.compactMap({
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            string += argumentString
        }
        
        return string
    }
    
    public var url: URL? {
        return URL(string: urlString)
    }
    
    public let httpMethod = "GET"
    
    public init(
            endpoint: RMEndpoint,
            pathComponents: [String] = [],
            queryParams: [URLQueryItem] = []
        ) {
            self.endpoint = endpoint
            self.pathComponents = pathComponents
            self.queryParams = queryParams
        }
    
    convenience init?(url: URL) {
        let string = url.absoluteString
           if !string.contains(Constant.baseUrl) {
               return nil
           }
           let trimmed = string.replacingOccurrences(of: Constant.baseUrl+"/", with: "")
           if trimmed.contains("/") {
               let components = trimmed.components(separatedBy: "/")
               if !components.isEmpty {
                   let endpointString = components[0] // Endpoint
                   var pathComponents: [String] = []
                   if components.count > 1 {
                       pathComponents = components
                       pathComponents.removeFirst()
                   }
                   if let rmEndpoint = RMEndpoint(
                       rawValue: endpointString
                   ) {
                       self.init(endpoint: rmEndpoint, pathComponents: pathComponents)
                       return
                   }
               }
           } else if trimmed.contains("?") {
               let components = trimmed.components(separatedBy: "?")
               if !components.isEmpty, components.count >= 2 {
                   let endpointString = components[0]
                   let queryItemsString = components[1]
                   // value=name&value=name
                   let queryItems: [URLQueryItem] = queryItemsString.components(separatedBy: "&").compactMap({
                       guard $0.contains("=") else {
                           return nil
                       }
                       let parts = $0.components(separatedBy: "=")

                       return URLQueryItem(
                           name: parts[0],
                           value: parts[1]
                       )
                   })

                   if let rmEndpoint = RMEndpoint(rawValue: endpointString) {
                       self.init(endpoint: rmEndpoint, queryParams: queryItems)
                       return
                   }
               }
           }

           return nil
    }
}

extension RMRequest {
    static let listCharactersRequest = RMRequest(endpoint: .character)
    static let listEpisodesRequest = RMRequest(endpoint: .episode)
}
