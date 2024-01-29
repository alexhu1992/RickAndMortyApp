//
//  RMCharacterCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Mengheng Hu on 1/27/24.
//

import Foundation

final class RMCharacterCollectionViewCellViewModel: Hashable, Equatable {
    
    public let characterId: Int
    public let characterName: String
    private let characterStatus: RMCharacterStatus
    private let characterImgUrl: URL?
    
    
    init(characterId: Int, characterName: String, characterStaus: RMCharacterStatus, characterImgUrl: URL?) {
        self.characterId = characterId
        self.characterImgUrl = characterImgUrl
        self.characterName = characterName
        self.characterStatus = characterStaus
    }
    
    public var characterStatusText: String {
        return "Status: \(characterStatus.text)"
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = characterImgUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        ImageLoader.shared.downloadImage(url, completion: completion)
    }
    
    static func == (lhs: RMCharacterCollectionViewCellViewModel, rhs: RMCharacterCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(characterName)
        hasher.combine(characterId)
        hasher.combine(characterStatus)
        hasher.combine(characterImgUrl)
    }
}
