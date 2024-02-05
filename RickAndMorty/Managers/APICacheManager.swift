//
//  APICacheManager.swift
//  RickAndMorty
//
//  Created by Mengheng Hu on 2/4/24.
//

import Foundation

final class APICacheManager {
    
    private var cacheDictionary: [RMEndpoint: NSCache<NSString, NSObject>] = [:]
    
    init() { 
        setUpCache()
    }
    
    public func cachedResponse(for endpoint: RMEndpoint, url: URL?) -> Data? {
        guard let targetCache = cacheDictionary[endpoint], let url = url else {
            return nil
        }
        let key = url.absoluteString as NSString
        return targetCache.object(forKey: key) as? Data
    }
    
    public func setCache(for endpoint: RMEndpoint, url: URL?, data: Data) {
        guard let targetCache = cacheDictionary[endpoint], let url = url else {
            return
        }
        let key = url.absoluteString as NSString
        targetCache.setObject(data as NSData, forKey: key)
    }
    
    private func setUpCache() {
        RMEndpoint.allCases.forEach({ endpoint in
            cacheDictionary[endpoint] = NSCache<NSString, NSObject>()
        })
    }
}
