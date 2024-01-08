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
    
    public func execute(_ request: RMRequest, completion: @escaping () -> Void){
        
    }
}