//
//  RMEpsidoeDetailedViewModel.swift
//  RickAndMorty
//
//  Created by Mengheng Hu on 2/4/24.
//

import UIKit

protocol RMEpisodeDetailedViewModelDelegate: AnyObject {
    func didFetchEpsidoeDetails()
}

final class RMEpisodeDetailedViewModel {
    private let endpointUrl: URL?
    
    private var dataTuple: (episode: RMEpisode, characters: [RMCharacter])? {
        didSet {
            createCellViewModels()
            deletegate?.didFetchEpsidoeDetails()
        }
    }
    
    enum SectionType {
        case information(viewModels: [RMEpisodeInfoCollectionViewCellViewModel])
        case characters(viewModel: [RMCharacterCollectionViewCellViewModel])
    }
    
    public weak var deletegate: RMEpisodeDetailedViewModelDelegate?
    
    public private(set) var cellViewModels: [SectionType] = []
    
    init(endpointUrl: URL?) {
        self.endpointUrl = endpointUrl
    }
    
    public func character(at index: Int) -> RMCharacter? {
        guard let dataTuple = dataTuple else {
            return nil
        }
        return dataTuple.characters[index]
    }
    
    public func fetchEpisodeData() {
        guard let url = endpointUrl, let request = RMRequest(url: url) else {
            return
        }
        
        RMService.shared.execute(request, expecting: RMEpisode.self) { [weak self] result in
            switch result {
            case .success(let model):
                self?.fetchRelatedCharacters(episode: model)
            case .failure(let failure):
                break
            }
        }
    }
    
    private func createCellViewModels() {
        guard let dataTuple = dataTuple else {
            return
        }
        let episode = dataTuple.episode
        let characters = dataTuple.characters
        
        var createdString = ""
        if let createdDate = RMCharacterInfoCollectionViewCellViewModel.dataFormatter.date(from: episode.created) {
            createdString = RMCharacterInfoCollectionViewCellViewModel.shortDateFormatter.string(from: createdDate)
        }
        cellViewModels = [
            .information(viewModels: [
                .init(title: "Episode Name", value: episode.name),
                .init(title: "Air Data", value: episode.air_date),
                .init(title: "Episode", value: episode.episode),
                .init(title: "Created", value: createdString),
            ]),
            .characters(viewModel: characters.compactMap({
                return RMCharacterCollectionViewCellViewModel(
                    characterId: $0.id,
                    characterName: $0.name,
                    characterStaus: $0.status,
                    characterImgUrl: URL(string: $0.image)
                )
            }))
        ]
    }
    
    private func fetchRelatedCharacters(episode: RMEpisode) {
        let requests: [RMRequest] = episode.characters.compactMap({
            return URL(string: $0)
        }).compactMap({
            return RMRequest(url: $0)
        })
        
        // parallel requests
        let group = DispatchGroup()
        var characters: [RMCharacter] = []
        
        for request in requests {
            group.enter()
            RMService.shared.execute(request, expecting: RMCharacter.self, completion: { result in
                defer {
                    group.leave()
                }
                switch result {
                case .success(let model):
                    characters.append(model)
                case .failure(let failure):
                    break
                }
            })
        }
        
        group.notify(queue: .main) {
            self.dataTuple = (
                episode: episode,
                characters: characters
            )
        }
    }
}
