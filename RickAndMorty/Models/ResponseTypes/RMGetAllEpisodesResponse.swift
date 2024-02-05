//
//  RMGetAllCharacterResponse.swift
//  RickAndMorty
//
//  Created by Mengheng Hu on 1/23/24.
//

import Foundation

struct RMGetAllEpisodesResponse: Codable {
    struct Info : Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
    
    let info: Info
    let results: [RMEpisode]
}
