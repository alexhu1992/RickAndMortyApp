//
//  RMCharacterCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Mengheng Hu on 1/27/24.
//

import Foundation

final class RMCharacterCollectionViewCellViewModel: NSObject {
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
        // TODO: abstract to an utility class
        guard let url = characterImgUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }
}
