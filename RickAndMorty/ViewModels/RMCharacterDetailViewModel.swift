//
//  RMCharacterDetailViewModel.swift
//  RickAndMorty
//
//  Created by Mengheng Hu on 1/28/24.
//

import Foundation

final class RMCharacterDetailViewModel {
    private let character: RMCharacter
    
    init(character: RMCharacter) {
        self.character = character
    }
    
    public var title: String {
        return character.name
    }
}
