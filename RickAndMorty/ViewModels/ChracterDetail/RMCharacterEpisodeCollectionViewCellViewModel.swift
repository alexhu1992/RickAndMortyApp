//
//  RMCharacterEpisodeCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Mengheng Hu on 2/1/24.
//

import Foundation
import UIKit

protocol RMEpisodeDataRender {
    var episode: String { get }
    var air_date: String { get }
    var name: String { get }
}

final class RMCharacterEpisodeCollectionViewCellViewModel: Hashable, Equatable {
    
    private let episodeDataUrl: URL?
    public let borderColor: UIColor
    private var isFetching = false
    private var dataBlock: ((RMEpisodeDataRender) -> Void)?
    private var episode: RMEpisode? {
        didSet {
            guard let model = episode else {
                return
            }
            dataBlock?(model)
        }
    }
    
    init(episodeDataUrl: URL?, borderColor: UIColor = .systemBlue) {
        self.episodeDataUrl = episodeDataUrl
        self.borderColor = borderColor
    }
    
    public func registerForData(_ block: @escaping (RMEpisodeDataRender) -> Void) {
        self.dataBlock = block
    }
    
    public func fetchEpisode() {
        guard !isFetching else {
            if let model = episode {
                dataBlock?(model)
            }
            return
        }
        guard let url = episodeDataUrl, let rmRequest = RMRequest(url: url) else {
            return
        }
        isFetching = true
        RMService.shared.execute(rmRequest, expecting: RMEpisode.self) { [weak self] result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self?.episode = success
                }
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.episodeDataUrl?.absoluteString ?? "")
    }
    
    static func == (lhs: RMCharacterEpisodeCollectionViewCellViewModel, rhs: RMCharacterEpisodeCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
