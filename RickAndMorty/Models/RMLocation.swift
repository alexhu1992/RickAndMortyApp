//
//  RMLocation.swift
//  RickAndMorty
//
//  Created by Mengheng Hu on 1/7/24.
//

import Foundation

struct RMLocation: Codable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
}
